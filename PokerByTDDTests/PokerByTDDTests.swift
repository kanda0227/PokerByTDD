//
//  PokerByTDDTests.swift
//  PokerByTDDTests
//
//  Created by Kanda Sena on 2018/11/15.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import XCTest
@testable import PokerByTDD

class PokerByTDDTests: XCTestCase {

    func testInitializeCard() {
        
        let card1 = Card(suit: .heart, rank: .three)
        XCTAssertEqual(card1.suit, .heart)
        XCTAssertEqual(card1.rank, .three)
        
        let card2 = Card(suit: .diamond, rank: .king)
        XCTAssertEqual(card2.suit, .diamond)
        XCTAssertEqual(card2.rank, .king)
    }
    
    func testCardNotation() {
        
        let card1 = Card(suit: .heart, rank: .three)
        XCTAssertEqual(card1.notation, "3♥")
    }
}
