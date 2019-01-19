//
//  Table.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/18.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

public final class Table {
    
    private var hands: [Hand] = []
    private var betCollection: [Hand : Int] = [:]
    
    public init() {}
    
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
    
    public func bet(hand: Hand, _ bet: Int = 0) {
        betCollection[hand] = bet
        hands.append(hand)
    }
    
    func receive(hand: Hand) -> Int {
        guard let bet = betCollection[hand],
            result(hand: hand) == .win else { return 0 }
        return bet * hand.hand().stlength
    }
    
    func ranking(hand: Hand) -> Int {
        return rankingArray.enumerated().flatMap { index, hands in
            hands.map { (rank: index, hand: $0) } }.filter { $0.hand == hand }.first!.rank + 1
    }
    
    public func result(hand: Hand) -> PokerResult {
        let winners = hands.filter { ranking(hand: $0) == 1 }
        if !winners.contains(hand) {
            return .lose
        } else if winners.count == 1 {
            return .win
        } else {
            return .draw
        }
    }
    
    public func receive(bet: Int, hand: Hand) -> Int {
        return bet * hand.hand().stlength * result(hand: hand).returnRate
    }
    
    public func resetGame() {
        hands.removeAll()
        betCollection.removeAll()
    }
}

public enum PokerResult {
    case win
    case lose
    case draw
    
    fileprivate var returnRate: Int {
        switch self {
        case .win:
            return 1
        default:
            return 0
        }
    }
}
