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
        let maxSameSuitCount = cards.enumerated().map { index, card in
            cards.filter { card.hasSameRank($0) }.count
            }.max()
        return maxSameSuitCount == 2
    }
    
    var isFlash: Bool {
        // カードが1枚もないときはフラッシュではないとする
        guard let card = cards.first else { return false }
        // 1枚だと常にフラッシュ！
        return cards.filter { card.hasSameSuit($0) }.count == cards.count
    }
    
    var isHighCard: Bool {
        return true
    }
}
