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
    
    private let dealer = Dealer()
    private let useCardNum = 5
    
    private var bet = 0
    
    private let updateCards: Binder<(cards: [Card], opponentCards: [Card])>
    private let handText: Binder<(hand: String?, opponentHand: String?, result: String?)>
    
    init(updateCards: Binder<(cards: [Card], opponentCards: [Card])>,
         handText: Binder<(hand: String?, opponentHand: String?, result: String?)>) {
        self.updateCards = updateCards
        self.handText = handText
    }
    
    func postStart(gatherCards: [Card], opponentCards: [Card], bet: Int) {
        self.bet = bet
        dealer.gatherCards(gatherCards + opponentCards)
        let cards = dealer.dealCards(useCardNum).sorted()
        updateCards.onNext((cards: cards, opponentCards: []))
        handText.onNext((hand: nil, opponentHand: nil, result: nil))
    }
    
    func postTrade(selected: [Card], notSelected: [Card]) {
        let cards = (dealer.tradeCards(selected) + notSelected).sorted()
        let opponentCards = dealer.dealCards(useCardNum).sorted()
        let hand = Hand(cards: cards, name: userName)
        let opponentHand = Hand(cards: opponentCards, name: opponentName)
        let resultText = Result.resultText(hand: hand, opponentHand: opponentHand, bet: bet)
        updateCards.onNext((cards: cards, opponentCards: opponentCards))
        handText.onNext((hand: hand.hand().text,
                         opponentHand: opponentHand.hand().text,
                         result: resultText))
    }
    
    private enum Result: String {
        case win = "勝ち(`･ω･´)"
        case lose = "負け(´･ω･`)"
        case draw = "引き分け(･_･)"
        
        static func resultText(hand: Hand, opponentHand: Hand, bet: Int) -> String {
            let (result, receive) = results(hand: hand, opponentHand: opponentHand, bet: bet)
            return result.text(receive: receive)
        }
        
        func text(receive: Int) -> String {
            return rawValue + " + \(receive)"
        }
        
        static fileprivate func results(hand: Hand, opponentHand: Hand, bet: Int) -> (Result, Int) {
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
