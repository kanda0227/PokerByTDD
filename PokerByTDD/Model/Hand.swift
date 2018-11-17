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
    
    var isPair: Bool {
        return PokerHand.pair.isPockerHand(cards: cards)
    }
    
    var isFlash: Bool {
        return PokerHand.flash.isPockerHand(cards: cards)
    }
    
    var isHighCard: Bool {
        return PokerHand.highCard.isPockerHand(cards: cards)
    }
}