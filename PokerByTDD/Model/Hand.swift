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
        return isPokerHand(.defaultOnePair)
    }
    
    var isTwoPair: Bool {
        return isPokerHand(.defaultTwoPair)
    }
    
    var isThreeCard: Bool {
        return isPokerHand(.defaultThreeCard)
    }
    
    var isFourCard: Bool {
        return isPokerHand(.defaultFourCard)
    }
    
    var isStraight: Bool {
        return isPokerHand(.straight)
    }
    
    var isFullHouse: Bool {
        return isPokerHand(.defaultFullHouse)
    }
    
    var isFlash: Bool {
        return isPokerHand(.flash)
    }
    
    var isStraightFlash: Bool {
        return isPokerHand(.straightFlash)
    }
    
    var isRoyalStraightFlash: Bool {
        return isPokerHand(.royalStraightFlash)
    }
    
    var isHighCard: Bool {
        return isPokerHand(.highCard)
    }
    
    /// カードの役を返します
    func hand() -> PokerHand {
        // 必ず何かしらに該当するはず
        return PokerHandDecisionHelper.pockerHand(cards: cards)
    }
    
    private func isPokerHand(_ pokerHand: PokerHand) -> Bool {
        return hand().sameHand(pokerHand)
    }
}
