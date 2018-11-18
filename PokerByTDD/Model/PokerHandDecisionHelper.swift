//
//  PokerHandDecisionHelper.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/18.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

/// ポーカーの役判定メソッド群
/// static なメソッドのみを想定している
/// インスタンス化を防ぐため enum で定義
enum PokerHandDecisionHelper {
    
    typealias Rank = PokerHand.Rank
    
    /// カードから役を判定します
    static func pockerHand(cards: [Card]) -> PokerHand {
        if isRoyalStraightFlash(cards) {
            return .royalStraightFlash
        } else if hasFlash(cards) && hasStraight(cards) {
            return .straightFlash
        } else if hasFlash(cards) {
            return .flash
        } else if hasStraight(cards) {
            return .straight
        } else if let fourRank = fourCard(cards) {
            return .fourCard(four: fourRank)
        } else if let threeRank = threeCard(cards),
            let pairRank = pairs(cards, pairsCount: 1)?.first {
            return .fullHouse(three: threeRank, two: pairRank)
        } else if let threeRank = threeCard(cards) {
            return .threeCard(three: threeRank)
        } else if let pairsRank = pairs(cards, pairsCount: 2),
            pairsRank.count == 2 {
            return .twoPair(pairMax: pairsRank[0], pairMin: pairsRank[1])
        } else if let pairRank = pairs(cards, pairsCount: 1)?.first {
            return .onePair(pair: pairRank)
        }
        
        return .highCard
    }
    
    /// カードにペアがあればペアの Rank を強い順にソートした配列で返します
    static private func pairs(_ cards: [Card], pairsCount: Int) -> [Rank]? {
        let pairs = cards.enumerated().map { index, card in
            (cards.filter { card.hasSameRank($0) }.count, card.rank)
            }.filter { $0.0 == 2 }.map { $0.1 }
        let pairRanks = Array(Set(pairs)).sorted { $0.stlength > $1.stlength }
        return pairRanks.isEmpty ? nil : pairRanks
    }
    
    /// カードに3枚組があれば Rank を返します
    static private func threeCard(_ cards: [Card]) -> Rank? {
        return cards.enumerated().map { index, card in
            (cards.filter { card.hasSameRank($0) }.count, card.rank)
            }.filter { $0.0 == 3 }.first?.1
    }
    
    /// カードに4枚組があれば Rank を返します
    static private func fourCard(_ cards: [Card]) -> Rank? {
        return cards.enumerated().map { index, card in
            (cards.filter { card.hasSameRank($0) }.count, card.rank)
            }.filter { $0.0 == 4 }.first?.1
    }
    
    static private func hasStraight(_ cards: [Card]) -> Bool {
        var ranks = Card.Rank.allCases
        ranks.insert(.ace, at: 0)
        return ranks.enumerated().filter { cards.map { $0.rank }.contains($0.element) }.map { $0.offset }.hasContinuous(cards.count)
    }
    
    static private func hasFlash(_ cards: [Card]) -> Bool {
        // カードが1枚もないときはフラッシュではないとする
        guard let card = cards.first else { return false }
        // 1枚だと常にフラッシュ！
        return cards.filter { card.hasSameSuit($0) }.count == cards.count
    }
    
    static private func isRoyalStraightFlash(_ cards: [Card]) -> Bool {
        let cardsRank = cards.map { $0.rank }
        // ここでロイヤル要素を絞り込み
        guard cardsRank.contains(.ace),
            cardsRank.contains(.king) else { return false }
        
        return hasStraight(cards)
            && hasFlash(cards)
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
