//
//  Table.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/18.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

struct Table {
    
    private let hands: [Hand]
    
    init(hands: [Hand]) {
        self.hands = hands
    }
    
    var ranking: [[String]] {
        let sortedHands = hands.sorted { $0.hand() > $1.hand() }
        var rankingArray: [[String]] = [
        ]
        var lastHand: Hand?
        sortedHands.forEach { hand in
            if let lastHand = lastHand, lastHand.hand() == hand.hand() {
                rankingArray[rankingArray.count - 1].append(hand.name)
            } else {
                rankingArray.append([hand.name])
            }
            lastHand = hand
        }
        return rankingArray
    }
}
