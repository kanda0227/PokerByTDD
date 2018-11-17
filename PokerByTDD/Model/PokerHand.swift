//
//  PokerHand.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/17.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

/// ポーカーの役一覧
enum PokerHand: CaseIterable {
    case onePair
    case flash
    case highCard
    
    func isPockerHand(cards: [Card]) -> Bool {
        switch self {
        case .onePair:
            return isOnePair(cards)
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
    
    private func isOnePair(_ cards: [Card]) -> Bool {
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
