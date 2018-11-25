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
    
    private let updateCards: Binder<(cards: [Card], opponentCards: [Card])>
    private let handText: Binder<(hand: String?, opponentHand: String?, result: String?)>
    
    init(updateCards: Binder<(cards: [Card], opponentCards: [Card])>,
         handText: Binder<(hand: String?, opponentHand: String?, result: String?)>) {
        self.updateCards = updateCards
        self.handText = handText
    }
    
    func postStart(gatherCards: [Card], opponentCards: [Card]) {
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
        let result = Result.result(hand: hand, opponentHand: opponentHand)
        updateCards.onNext((cards: cards, opponentCards: opponentCards))
        handText.onNext((hand: hand.hand().text,
                         opponentHand: opponentHand.hand().text,
                         result: result.rawValue))
    }
    
    private enum Result: String {
        case win = "勝ち(`･ω･´)"
        case lose = "負け(´･ω･`)"
        case draw = "引き分け(･_･)"
        
        static func result(hand: Hand, opponentHand: Hand) -> Result {
            let table = Table()
            table.bet(hand: hand, 0)
            table.bet(hand: opponentHand, 0)
            let ranking = table.ranking(hand: hand)
            let opponentRanking = table.ranking(hand: opponentHand)
            if ranking == opponentRanking {
                return .draw
            } else if ranking == 1 {
                return .win
            } else {
                return .lose
            }
        }
    }
    
    private let userName = "user"
    private let opponentName = "opponent"
}
