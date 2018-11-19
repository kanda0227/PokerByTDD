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
    
    /// カードから役を判定します
    static func pockerHand(cards: [Card]) -> PokerHand {
        if isRoyalStraightFlash(cards) {
            return .royalStraightFlash(cards: cards)
        } else if hasFlash(cards) && hasStraight(cards) {
            return .straightFlash(cards: cards)
        } else if hasFlash(cards) {
            return .flash(cards: cards)
        } else if hasStraight(cards) {
            return .straight(cards: cards)
        } else if let fourRank = fourCard(cards) {
            return .fourCard(cards: cards, four: fourRank)
        } else if let threeRank = threeCard(cards),
            let pairRank = pairs(cards, pairsCount: 1)?.first {
            return .fullHouse(cards: cards, three: threeRank, two: pairRank)
        } else if let threeRank = threeCard(cards) {
            return .threeCard(cards: cards, three: threeRank)
        } else if let pairsRank = pairs(cards, pairsCount: 2),
            pairsRank.count == 2 {
            return .twoPair(cards: cards, pairMax: pairsRank[0], pairMin: pairsRank[1])
        } else if let pairRank = pairs(cards, pairsCount: 1)?.first {
            return .onePair(cards: cards, pair: pairRank)
        }
        
        return .highCard(cards: cards)
    }
    
    /// カードにペアがあればペアの Rank を強い順にソートした配列で返します
    static private func pairs(_ cards: [Card], pairsCount: Int) -> [Card]? {
        let pairs = cards.enumerated().map { index, card in
            (cards.filter { card.hasSameRank($0) }.count, card)
            }.filter { $0.0 == 2 }.map { $0.1 }
        let pairRanks = pairs.sorted().enumerated()
            // 同じランクが2個ずつ並ぶはずなので奇数の方だけピック
            .filter { $0.offset % 2 == 1 }
            .map { $0.element }
        return pairRanks.isEmpty ? nil : pairRanks
    }
    
    /// カードに3枚組があれば Rank を返します
    static private func threeCard(_ cards: [Card]) -> Card? {
        return cards.enumerated().map { index, card in
            (cards.filter { card.hasSameRank($0) }.count, card)
            }.filter { $0.0 == 3 }.first?.1
    }
    
    /// カードに4枚組があれば Rank を返します
    static private func fourCard(_ cards: [Card]) -> Card? {
        return cards.enumerated().map { index, card in
            (cards.filter { card.hasSameRank($0) }.count, card)
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
