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
import Model

// MARK: - PokerViewPresenter
/// ポーカー画面の Presenter
public final class PokerViewPresenter {
    
    /// カードの配布や交換をしてくれるディーラーさん
    private let dealer = Dealer()
    /// 今回は手札が5枚ずつのポーカーを想定
    private let useCardNum = 5
    
    private let bag = DisposeBag()
    
    private var bet = 0
    
    /// ユーザーの手札
    private var userCards: [(card: Card, isSelected: Bool)] = []
    /// 対戦相手の手札
    private var opponentCards: [Card] = []
    
    /// ユーザーと対戦相手のカードのビューを更新します
    private let updateCards: Binder<(cards: [Card], opponentCards: [Card])>
    /// ユーザーと対戦相手の役のテキストを表示します
    private let handText: Binder<(hand: String?, opponentHand: String?, result: String?)>
    /// 所持金の表示を更新します
    private let wallet: Binder<(money: Int, count: Int, perTime: Int, shouldPresentMoney: Bool)>
    /// ユーザーのカードをめくります
    private let turnOverUserCards: Binder<Bool>
    /// 対戦相手のカードをめくります
    private let turnOverOpponentCards: Binder<Bool>
    /// カードの選択可否を切り替えます
    private let switchSelectableCards: Binder<Bool>
    /// スタートボタンの有効・無効を切り替えます
    private let switchIsStartButtonEnabled: Binder<Bool>
    /// トレードボタンの有効・無効を切り替えます
    private let switchIsTradeButtonEnabled: Binder<Bool>
    
    public init(updateCards: Binder<(cards: [Card], opponentCards: [Card])>,
         handText: Binder<(hand: String?, opponentHand: String?, result: String?)>,
         wallet: Binder<(money: Int, count: Int, perTime: Int, shouldPresentMoney: Bool)>,
         turnOverUserCards: Binder<Bool>,
         turnOverOpponentCards: Binder<Bool>,
         switchSelectableCards: Binder<Bool>,
         switchIsStartButtonEnabled: Binder<Bool>,
         switchIsTradeButtonEnabled: Binder<Bool>) {
        self.updateCards = updateCards
        self.handText = handText
        self.wallet = wallet
        self.turnOverUserCards = turnOverUserCards
        self.turnOverOpponentCards = turnOverOpponentCards
        self.switchSelectableCards = switchSelectableCards
        self.switchIsStartButtonEnabled = switchIsStartButtonEnabled
        self.switchIsTradeButtonEnabled = switchIsTradeButtonEnabled
        
        setupEvent()
    }
    
    private func setupEvent() {
        // 所持金の表示
        Wallet.shared.observable().subscribe(wallet.asObserver()).disposed(by: bag)
    }
}

// MARK: - VC 側で使用するためのメソッド等
extension PokerViewPresenter {
    
    /// 所持金を返します
    public func walletContent() -> Int {
        return Wallet.shared.value()
    }
    
    /// スタートボタンのタップ時に呼んでください
    public func postTapStartButton() {
        turnOverUserCards.onNext(true)
        turnOverOpponentCards.onNext(true)
    }
    
    /// ゲームスタート時に呼んでください
    public func postStart(bet: Int?) {
        guard let bet = bet else { return }
        self.bet = bet
        Wallet.shared.pay(bet)
        dealer.gatherCards(userCards.map { $0.card } + opponentCards)
        userCards = dealer.dealCards(useCardNum).sorted().map { ($0, false) }
        opponentCards = dealer.dealCards(useCardNum).sorted()
        updateCards.onNext((cards: userCards.map { $0.card },
                            opponentCards: opponentCards))
        handText.onNext((hand: nil, opponentHand: nil, result: nil))
        
        turnOverUserCards.onNext(false)
        switchSelectableCards.onNext(true)
        switchIsStartButtonEnabled.onNext(false)
        switchIsTradeButtonEnabled.onNext(true)
        TopTabSelectableNotification.shared.post(selectable: false)
    }
    
    /// カードの選択状態が変わるときに呼んでください
    public func switchIsSelectCard(tag: Int, isSelected: Bool) {
        userCards[tag].isSelected = isSelected
    }
    
    /// カード交換ボタンのタップ時に呼んでください
    public func postTrade() {
        let selected = userCards.filter { $0.isSelected }.map { $0.card }
        let notSelected = userCards.filter { !$0.isSelected }.map { $0.card }
        userCards = (dealer.tradeCards(selected) + notSelected).sorted().map { ($0, false) }
        let cards = userCards.map { $0.card }
        Wallet.shared.receipt(Result.receive(user: cards, opponent: opponentCards, bet: bet))
        updateCards.onNext((cards: userCards.map { $0.card }, opponentCards: opponentCards))
        handText.onNext(Result.resultText(user: cards, opponent: opponentCards, bet: bet))
        
        turnOverOpponentCards.onNext(false)
        switchSelectableCards.onNext(false)
        switchIsStartButtonEnabled.onNext(true)
        switchIsTradeButtonEnabled.onNext(false)
        TopTabSelectableNotification.shared.post(selectable: true)
    }
}

// MARK: - 表示する勝敗結果の計算ロジック
extension PokerViewPresenter {
    
    private enum Result: String {
        case win = "勝ち(`･ω･´)"
        case lose = "負け(´･ω･`)"
        case draw = "引き分け(･_･)"
        
        static fileprivate func resultText(user: [Card], opponent: [Card], bet: Int) -> (hand: String?, opponentHand: String?, result: String?) {
            let (result, receive, handTexts) = results(userCards: user, opponentCards: opponent, bet: bet)
            return (handTexts.user, handTexts.opponent, result.text(receive: receive))
        }
        
        static fileprivate func receive(user: [Card], opponent: [Card], bet: Int) -> Int {
            return results(userCards: user, opponentCards: opponent, bet: bet).receive
        }
        
        fileprivate func text(receive: Int) -> String {
            return rawValue + " + \(receive)"
        }
        
        static private func results(userCards: [Card], opponentCards: [Card], bet: Int) -> (result: Result, receive: Int, handTexts: (user: String, opponent: String)) {
            let table = Table()
            let userHand = Hand(cards: userCards, name: "user")
            let opponentHand = Hand(cards: opponentCards, name: "opponent")
            table.bet(hand: userHand, bet)
            table.bet(hand: opponentHand, 0)
            let ranking = table.ranking(hand: userHand)
            let opponentRanking = table.ranking(hand: opponentHand)
            let receive = table.receive(hand: userHand)
            let handTexts = (userHand.hand().text, opponentHand.hand().text)
            if ranking == opponentRanking {
                return (.draw, receive, handTexts)
            } else if ranking == 1 {
                return (.win, receive, handTexts)
            } else {
                return (.lose, receive, handTexts)
            }
        }
    }
}
