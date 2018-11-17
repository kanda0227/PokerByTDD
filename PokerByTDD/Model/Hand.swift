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

/// ポーカーの役一覧
private enum PokerHand: CaseIterable {
    case pair
    case flash
    case highCard
    
    func isPockerHand(cards: [Card]) -> Bool {
        switch self {
        case .pair:
            return isPair(cards)
        case .flash:
            return isFlash(cards)
        case .highCard:
            // ハイカード以外の，どの役にも当てはまらない場合に true を返します
            return PokerHand.allCases
                .filter { $0 != .highCard }
                .filter { $0.isPockerHand(cards: cards) }
                .isEmpty
        }
    }
    
    private func isPair(_ cards: [Card]) -> Bool {
        let maxSameSuitCount = cards.enumerated().map { index, card in
            cards.filter { card.hasSameRank($0) }.count
            }.max()
        return maxSameSuitCount == 2
    }
    
    private func isFlash(_ cards: [Card]) -> Bool {
        // カードが1枚もないときはフラッシュではないとする
        guard let card = cards.first else { return false }
        // 1枚だと常にフラッシュ！
        return cards.filter { card.hasSameSuit($0) }.count == cards.count
    }
}
