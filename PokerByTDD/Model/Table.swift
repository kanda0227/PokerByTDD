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
    
    var ranking: [Int] {
        return hands.enumerated().sorted { $0.element.hand() > $1.element.hand() }.map { $0.offset }
    }
}
