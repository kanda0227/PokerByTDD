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
    
    // MARK: - Card
    
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

        // rank: 等しくない suit: 等しくない
        XCTAssertNotEqual(Card(rank: .three, suit: .heart),
                          Card(rank: .ace, suit: .club))
        
        // rank: 等しい suit: 等しくない
        XCTAssertEqual(Card(rank: .three, suit: .heart),
                          Card(rank: .three, suit: .club))
    }
    
    func testCardCompare() {
        
        XCTAssertLessThan(Card(rank: .three, suit: .heart),
                          Card(rank: .ace, suit: .club))
        
        XCTAssertGreaterThan(Card(rank: .ace, suit: .heart),
                          Card(rank: .three, suit: .club))
    }
    
    // MARK: - Hand
    
    func testIsPair() {

        // 2枚・ペア
        let hand_A = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club)])
        XCTAssertTrue(hand_A.isPair)
        
        // 2枚・ペアではない
        let hand_B = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .ace, suit: .club)])
        XCTAssertFalse(hand_B.isPair)
        
        // 0枚
        let hand_C = Hand(cards: [])
        XCTAssertFalse(hand_C.isPair)
        
        // 1枚
        let hand_D = Hand(cards: [Card(rank: .ace, suit: .spade)])
        XCTAssertFalse(hand_D.isPair)
        
        // 3枚・スリーカード
        let hand_E = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .three, suit: .diamond)])
        XCTAssertFalse(hand_E.isPair)
    }
    
    func testIsFlash() {
        
        // 2枚・フラッシュ
        let hand_A = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .ace, suit: .heart)])
        XCTAssertTrue(hand_A.isFlash)
        
        // 2枚・フラッシュじゃない
        let hand_B = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club)])
        XCTAssertFalse(hand_B.isFlash)
        
        // 0枚
        let hand_C = Hand(cards: [])
        XCTAssertFalse(hand_C.isFlash)
        
        // 1枚についてはこれで仕様として正しいのか微妙なのでテストは記述しない
        // 一応 hand_D は欠番にしておきますね
        
        // 3枚・フラッシュじゃない
        let hand_E = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .ace, suit: .heart),
                                  Card(rank: .jack, suit: .diamond)])
        XCTAssertFalse(hand_E.isFlash)
        
        // 3枚・フラッシュ
        let hand_F = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .ace, suit: .heart),
                                  Card(rank: .jack, suit: .heart)])
        XCTAssertTrue(hand_F.isFlash)
    }
    
    func testIsHighCard() {
        
        let hand_A = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .ace, suit: .spade)])
        XCTAssertTrue(hand_A.isHighCard)
        
        let hand_B = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .spade)])
        XCTAssertFalse(hand_B.isHighCard)
    }
}
