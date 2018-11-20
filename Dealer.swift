//
//  Dealer.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/20.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

final class Dealer {
    
    private lazy var trumpCase: [Card] = allCards
    
    private var allCards: [Card] {
        return Card.Rank.allCases.flatMap { rank in
            Card.Suit.allCases.map { suit in
                Card(rank: rank, suit: suit)
            }
        }
    }
    
    func dealCards(_ n: Int) -> [Card] {
        guard trumpCase.count >= n else {
            // 配るカードが足りないのでとりあえず手持ちを全部渡す
            return trumpCase
        }
        // TODO：ランダム性を持たせるためのロジックを追加
        var cards: [Card] = []
        for _ in 0..<n {
            // とりあえず頭から n 枚取り出して渡す
            cards.append(trumpCase.removeFirst())
        }
        return cards
    }
    
    func gatherCards(_ cards: [Card]) {
        trumpCase.append(contentsOf: cards)
    }
    
    func tradeCards(_ cards: [Card]) -> [Card] {
        let returnCards = dealCards(cards.count)
        // 交換に出したカードは返してあげない
        trumpCase.append(contentsOf: cards)
        return returnCards
    }
}
