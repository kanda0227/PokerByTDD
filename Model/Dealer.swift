//
//  Dealer.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/20.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

public final class Dealer {
    
    private lazy var trumpCase: [Card] = allCards
    
    public init() {}
    
    private var allCards: [Card] {
        return Card.Rank.allCases.flatMap { rank in
            Card.Suit.allCases.map { suit in
                Card(rank: rank, suit: suit)
            }
        }
    }
    
    public func dealCards(_ n: Int) -> [Card] {
        guard trumpCase.count >= n else {
            // 配るカードが足りないのでとりあえず手持ちを全部渡す
            return trumpCase
        }
        var cards: [Card] = []
        for _ in 0..<n {
            if let card = trumpCase.randomElement(),
                let index = trumpCase.firstIndex(of: card) {
                cards.append(card)
                trumpCase.remove(at: index)
            }
        }
        return cards
    }
    
    public func gatherCards(_ cards: [Card]) {
        trumpCase.append(contentsOf: cards)
    }
    
    public func tradeCards(_ cards: [Card]) -> [Card] {
        let returnCards = dealCards(cards.count)
        // 交換に出したカードは返してあげない
        trumpCase.append(contentsOf: cards)
        return returnCards
    }
}
