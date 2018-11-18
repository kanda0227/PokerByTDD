//
//  Hand.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/17.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

struct Hand {
    
    private let cards: [Card]
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    var isOnePair: Bool {
        return PokerHand.onePair.isPockerHand(cards: cards)
    }
    
    var isTwoPair: Bool {
        return PokerHand.twoPair.isPockerHand(cards: cards)
    }
    
    var isThreeCard: Bool {
        return PokerHand.threeCard.isPockerHand(cards: cards)
    }
    
    var isFourCard: Bool {
        return PokerHand.fourCard.isPockerHand(cards: cards)
    }
    
    var isStraight: Bool {
        return PokerHand.straight.isPockerHand(cards: cards)
    }
    
    var isFullHouse: Bool {
        return PokerHand.fullHouse.isPockerHand(cards: cards)
    }
    
    var isFlash: Bool {
        return PokerHand.flash.isPockerHand(cards: cards)
    }
    
    var isStraightFlash: Bool {
        return PokerHand.straightFlash.isPockerHand(cards: cards)
    }
    
    var isRoyalStraightFlash: Bool {
        return PokerHand.royalStraightFlash.isPockerHand(cards: cards)
    }
    
    var isHighCard: Bool {
        return PokerHand.highCard.isPockerHand(cards: cards)
    }
    
    /// カードの役を返します
    func hand() -> PokerHand {
        return .royalStraightFlash
    }
}
