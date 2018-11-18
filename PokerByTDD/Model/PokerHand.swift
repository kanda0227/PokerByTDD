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
    case twoPair
    case threeCard
    case fourCard
    case straight
    case flash
    case highCard
    
    func isPockerHand(cards: [Card]) -> Bool {
        switch self {
        case .onePair:
            return hasPairs(cards, pairsCount: 1)
                && !hasThreeCard(cards)
        case .twoPair:
            return hasPairs(cards, pairsCount: 2)
        case .threeCard:
            return hasThreeCard(cards)
                && !hasPairs(cards, pairsCount: 1)
        case .fourCard:
            return hasFourCard(cards)
        case .straight:
            return hasStraight(cards)
        case .flash:
            return hasFlash(cards)
        case .highCard:
            return !hasOtherHands(cards: cards)
        }
    }
    
    private func hasPairs(_ cards: [Card], pairsCount: Int) -> Bool {
        let hasPairsCount = cards.enumerated().map { index, card in
            cards.filter { card.hasSameRank($0) }.count
            }.filter { $0 == 2 }.count / 2
        return hasPairsCount == pairsCount
    }
    
    private func hasThreeCard(_ cards: [Card]) -> Bool {
        return cards.enumerated().map { index, card in
            cards.filter { card.hasSameRank($0) }.count
            }.contains(3)
    }
    
    private func hasFourCard(_ cards: [Card]) -> Bool {
        return cards.enumerated().map { index, card in
            cards.filter { card.hasSameRank($0) }.count
            }.contains(4)
    }
    
    private func hasStraight(_ cards: [Card]) -> Bool {
        var ranks = Card.Rank.allCases
        ranks.insert(.ace, at: 0)
        guard let strongestCard = cards.max(),
            let lastIndex = ranks.lastIndex(of: strongestCard.rank),
            lastIndex >= cards.count - 1
            else { return false }
        let firstIndex = lastIndex - (cards.count - 1)
        let sortedCards = cards.sorted()
        // ソートしたカードのランク配列が ranks の部分配列になっていればストレート
        return ranks[firstIndex...lastIndex].enumerated().filter { $0.element == sortedCards[$0.offset].rank }.count == cards.count
    }
    
    private func hasFlash(_ cards: [Card]) -> Bool {
        // カードが1枚もないときはフラッシュではないとする
        guard let card = cards.first else { return false }
        // 1枚だと常にフラッシュ！
        return cards.filter { card.hasSameSuit($0) }.count == cards.count
    }
    
    /// 指定の役以外の役を持つかどうかを判定
    /// ただしハイカードを持つかどうかは判定しません
    private func hasOtherHands(cards: [Card]) -> Bool {
        let hasNot = PokerHand.allCases
            .filter { $0 != .highCard && $0 != self }
            .filter { $0.isPockerHand(cards: cards) }
            .isEmpty
        return !hasNot
    }
}
