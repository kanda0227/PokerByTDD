//
//  Table.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/18.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

class Table {
    
    private var hands: [Hand] = []
    private var betCollection: [Hand : Int] = [:]
    
    init() {}
    
    private var rankingArray: [[Hand]] {
        let sortedHands = hands.sorted { $0.hand() > $1.hand() }
        var rankingArray: [[Hand]] = [
        ]
        var lastHand: Hand?
        sortedHands.forEach { hand in
            if let lastHand = lastHand, lastHand.hand() == hand.hand() {
                rankingArray[rankingArray.count - 1].append(hand)
            } else {
                rankingArray.append([hand])
            }
            lastHand = hand
        }
        return rankingArray
    }
    
    func bet(hand: Hand, _ bet: Int) {
        betCollection[hand] = bet
        hands.append(hand)
    }
    
    func receive(hand: Hand) -> Int {
        guard let bet = betCollection[hand],
            ranking(hand: hand) == 1 else { return 0 }
        return bet * hand.hand().stlength
    }
    
    func ranking(hand: Hand) -> Int {
        return rankingArray.enumerated().flatMap { index, hands in
            hands.map { (rank: index, hand: $0) } }.filter { $0.hand == hand }.first!.rank + 1
    }
    
    func resetGame() {
        hands.removeAll()
        betCollection.removeAll()
    }
}
