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
}
