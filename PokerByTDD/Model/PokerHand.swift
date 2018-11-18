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
    case fullHouse
    case flash
    case straightFlash
    case royalStraightFlash
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
                && !hasFlash(cards)
        case .fullHouse:
            return hasThreeCard(cards)
                && hasPairs(cards, pairsCount: 1)
        case .flash:
            return hasFlash(cards)
                && !hasStraight(cards)
        case .straightFlash:
            return hasStraight(cards)
                && hasFlash(cards)
                && !isRoyalStraightFlash(cards)
        case .royalStraightFlash:
            return isRoyalStraightFlash(cards)
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
        return ranks.enumerated().filter { cards.map { $0.rank }.contains($0.element) }.map { $0.offset }.hasContinuous(cards.count)
    }
    
    private func hasFlash(_ cards: [Card]) -> Bool {
        // カードが1枚もないときはフラッシュではないとする
        guard let card = cards.first else { return false }
        // 1枚だと常にフラッシュ！
        return cards.filter { card.hasSameSuit($0) }.count == cards.count
    }
    
    private func isRoyalStraightFlash(_ cards: [Card]) -> Bool {
        let cardsRank = cards.map { $0.rank }
        // ここでロイヤル要素を絞り込み
        guard cardsRank.contains(.ace) && cardsRank.contains(.king) else { return false }
        return hasStraight(cards)
            && hasFlash(cards)
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

extension PokerHand: Comparable {
    
    static func < (lhs: PokerHand, rhs: PokerHand) -> Bool {
        return true
    }
}

private extension Array where Element==Int {
    /// n連続した数値を持つかどうかを判定
    func hasContinuous(_ n: Int) -> Bool {
        var counter = 1
        var latestElem = 0
        let sortedElems = sorted()
        for i in 0..<count {
            let elem = sortedElems[i]
            let isContinuous = ((latestElem + 1) == elem)
            counter = isContinuous ? counter + 1 : 1
            latestElem = elem
            guard counter < n else { break }
        }
        return counter >= n
    }
}
