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
    
    func testCardNotation() {
        
        let card1 = Card(rank: .three, suit: .heart)
        XCTAssertEqual(card1.notation, "3♥")
        
        let card2 = Card(rank: .king, suit: .diamond)
        XCTAssertEqual(card2.notation, "K♦︎")
    }
    
    func testSameRank() {
        
        let card1 = Card(rank: .three, suit: .heart)
        let card2 = Card(rank: .three, suit: .club)
        XCTAssertTrue(card1.hasSameRank(card2))
        
        let card3 = Card(rank: .three, suit: .heart)
        let card4 = Card(rank: .ace, suit: .club)
        XCTAssertFalse(card3.hasSameRank(card4))
    }
    
    func testSameSuit() {
        
        let card1 = Card(rank: .three, suit: .heart)
        let card2 = Card(rank: .ace, suit: .heart)
        XCTAssertTrue(card1.hasSameSuit(card2))
        
        let card3 = Card(rank: .three, suit: .heart)
        let card4 = Card(rank: .ace, suit: .club)
        XCTAssertFalse(card3.hasSameSuit(card4))
    }
    
    func testCardEqual() {
        
        // rank: 等しい suit: 等しい
        let card1 = Card(rank: .three, suit: .heart)
        let card2 = Card(rank: .three, suit: .heart)
        XCTAssertEqual(card1, card2)
        
        // rank: 等しくない suit: 等しくない
        let card3 = Card(rank: .three, suit: .heart)
        let card4 = Card(rank: .ace, suit: .club)
        XCTAssertNotEqual(card3, card4)
        
        // rank: 等しい suit: 等しくない
        let card5 = Card(rank: .three, suit: .heart)
        let card6 = Card(rank: .three, suit: .club)
        XCTAssertNotEqual(card5, card6)

        // rank: 等しくない suit: 等しい
        let card7 = Card(rank: .three, suit: .heart)
        let card8 = Card(rank: .ace, suit: .heart)
        XCTAssertNotEqual(card7, card8)

    }
}
