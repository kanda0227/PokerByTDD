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
    
    private let updateCards: Binder<[Card]>
    private let handText: Binder<String?>
    
    init(updateCards: Binder<[Card]>,
         handText: Binder<String?>) {
        self.updateCards = updateCards
        self.handText = handText
    }
    
    func postStart(gatherCards: [Card]) {
        dealer.gatherCards(gatherCards)
        let cards = dealer.dealCards(useCardNum).sorted()
        updateCards.onNext(cards)
        handText.onNext(nil)
    }
    
    func postTrade(selected: [Card], notSelected: [Card]) {
        let cards = (dealer.tradeCards(selected) + notSelected).sorted()
        updateCards.onNext(cards)
        handText.onNext(Hand(cards: cards).hand().text)
    }
    
    private enum Result: String {
        case win = "勝ち(`･ω･´)"
        case lose = "負け(´･ω･`)"
        case draw = "引き分け(･_･)"
        
        static func result(hand: Hand, opponentHand: Hand) -> Result {
            let table = Table(hands: [hand, opponentHand])
            let ranking = table.ranking
            if ranking.first?.count == 2 {
                return .draw
            } else if ranking.first?.first != hand.name {
                return .lose
            } else {
                return .win
            }
        }
    }
    
    private let userName = "user"
    private let opponentName = "opponent"
}
