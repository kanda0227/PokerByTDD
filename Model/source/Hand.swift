//
//  Hand.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/17.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

public struct Hand: Hashable {
    
    private let cards: [Card]
    
    private let name: String
    
    public init(cards: [Card], name: String = "no_name") {
        self.cards = cards
        self.name = name
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
        return isPokerHand(.defaultStraight)
    }
    
    var isFullHouse: Bool {
        return isPokerHand(.defaultFullHouse)
    }
    
    var isFlash: Bool {
        return isPokerHand(.defaultFlash)
    }
    
    var isStraightFlash: Bool {
        return isPokerHand(.defaultStraightFlash)
    }
    
    var isRoyalStraightFlash: Bool {
        return isPokerHand(.defaultRoyalStraightFlash)
    }
    
    var isHighCard: Bool {
        return isPokerHand(.defaultHighCard)
    }
    
    /// カードの役を返します
    public func hand() -> PokerHand {
        // 必ず何かしらに該当するはず
        return PokerHandDecisionHelper.pockerHand(cards: cards)
    }
    
    private func isPokerHand(_ pokerHand: PokerHand) -> Bool {
        return hand().sameHand(pokerHand)
    }
}
