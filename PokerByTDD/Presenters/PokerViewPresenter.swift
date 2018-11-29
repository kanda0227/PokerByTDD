//
//  PokerViewPresenter.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/22.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PokerViewPresenter {
    
    /// カードの配布や交換をしてくれるディーラーさん
    private let dealer = Dealer()
    /// 今回は手札が5枚ずつのポーカーを想定
    private let useCardNum = 5
    
    private var bet = 0
    /// 所持金
    private var wallet = 100 { // TODO: 初期値を考えて所持金は永続化したものを使いたい
        didSet {
            walletText.onNext("\(wallet)")
        }
    }
    
    /// ユーザーの手札
    private var userCards: [(card: Card, isSelected: Bool)] = []
    /// 対戦相手の手札
    private var opponentCards: [Card] = []
    
    /// ユーザーと対戦相手のカードのビューを更新します
    private let updateCards: Binder<(cards: [Card], opponentCards: [Card])>
    /// ユーザーと対戦相手の役のテキストを表示します
    private let handText: Binder<(hand: String?, opponentHand: String?, result: String?)>
    /// 所持金の表示を更新します
    private let walletText: Binder<String>
    /// ユーザーのカードをめくります
    private let turnOverUserCards: Binder<Bool>
    /// 対戦相手のカードをめくります
    private let turnOverOpponentCards: Binder<Bool>
    
    init(updateCards: Binder<(cards: [Card], opponentCards: [Card])>,
         handText: Binder<(hand: String?, opponentHand: String?, result: String?)>,
         walletText: Binder<String>,
         turnOverUserCards: Binder<Bool>,
         turnOverOpponentCards: Binder<Bool>) {
        self.updateCards = updateCards
        self.handText = handText
        self.walletText = walletText
        self.turnOverUserCards = turnOverUserCards
        self.turnOverOpponentCards = turnOverOpponentCards
        
        self.walletText.onNext("\(wallet)")
    }
    
    func walletContent() -> Int {
        return wallet
    }
    
    /// スタートボタンのタップ時に呼んでください
    func postTapStartButton() {
        turnOverUserCards.onNext(true)
        turnOverOpponentCards.onNext(true)
    }
    
    /// ゲームスタート時に呼んでください
    func postStart(bet: Int) {
        self.bet = bet
        self.wallet -= bet
        dealer.gatherCards(userCards.map { $0.card } + opponentCards)
        userCards = dealer.dealCards(useCardNum).sorted().map { ($0, false) }
        opponentCards = dealer.dealCards(useCardNum).sorted()
        updateCards.onNext((cards: userCards.map { $0.card },
                            opponentCards: opponentCards))
        handText.onNext((hand: nil, opponentHand: nil, result: nil))
        turnOverUserCards.onNext(false)
    }
    
    /// カードの選択状態が変わるときに呼んでください
    func switchIsSelectCard(tag: Int, isSelected: Bool) {
        userCards[tag].isSelected = isSelected
    }
    
    /// カード交換ボタンのタップ時に呼んでください
    func postTrade() {
        let selected = userCards.filter { $0.isSelected }.map { $0.card }
        let notSelected = userCards.filter { !$0.isSelected }.map { $0.card }
        userCards = (dealer.tradeCards(selected) + notSelected).sorted().map { ($0, false) }
        let hand = Hand(cards: userCards.map { $0.card }, name: userName)
        let opponentHand = Hand(cards: opponentCards, name: opponentName)
        wallet += Result.receive(hand: hand, opponentHand: opponentHand, bet: bet)
        updateCards.onNext((cards: userCards.map { $0.card }, opponentCards: opponentCards))
        handText.onNext((hand: hand.hand().text,
                         opponentHand: opponentHand.hand().text,
                         result: Result.resultText(hand: hand, opponentHand: opponentHand, bet: bet)))
        turnOverOpponentCards.onNext(false)
    }
    
    private enum Result: String {
        case win = "勝ち(`･ω･´)"
        case lose = "負け(´･ω･`)"
        case draw = "引き分け(･_･)"
        
        static fileprivate func resultText(hand: Hand, opponentHand: Hand, bet: Int) -> String {
            let (result, receive) = results(hand: hand, opponentHand: opponentHand, bet: bet)
            return result.text(receive: receive)
        }
        
        static fileprivate func receive(hand: Hand, opponentHand: Hand, bet: Int) -> Int {
            return results(hand: hand, opponentHand: opponentHand, bet: bet).receive
        }
        
        fileprivate func text(receive: Int) -> String {
            return rawValue + " + \(receive)"
        }
        
        static private func results(hand: Hand, opponentHand: Hand, bet: Int) -> (result: Result, receive: Int) {
            let table = Table()
            table.bet(hand: hand, bet)
            table.bet(hand: opponentHand, 0)
            let ranking = table.ranking(hand: hand)
            let opponentRanking = table.ranking(hand: opponentHand)
            let receive = table.receive(hand: hand)
            if ranking == opponentRanking {
                return (.draw, receive)
            } else if ranking == 1 {
                return (.win, receive)
            } else {
                return (.lose, receive)
            }
        }
    }
    
    private let userName = "user"
    private let opponentName = "opponent"
}
