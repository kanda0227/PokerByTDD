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
        
        XCTAssertLessThanOrEqual(Card(rank: .ace, suit: .heart),
                          Card(rank: .ace, suit: .heart))
    }
    
    // MARK: - Hand
    
    func testIsOnePair() {

        // 2枚・ペア
        let hand_A = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club)])
        XCTAssertTrue(hand_A.isOnePair)
        
        // 2枚・ペアではない
        let hand_B = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .ace, suit: .club)])
        XCTAssertFalse(hand_B.isOnePair)
        
        // 0枚
        let hand_C = Hand(cards: [])
        XCTAssertFalse(hand_C.isOnePair)
        
        // 1枚
        let hand_D = Hand(cards: [Card(rank: .ace, suit: .spade)])
        XCTAssertFalse(hand_D.isOnePair)
        
        // 3枚・スリーカード
        let hand_E = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .three, suit: .diamond)])
        XCTAssertFalse(hand_E.isOnePair)
        
        // 5枚・フルハウス時
        let hand_F = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .three, suit: .diamond),
                                  Card(rank: .ace, suit: .club),
                                  Card(rank: .ace, suit: .spade)])
        XCTAssertFalse(hand_F.isOnePair)
    }
    
    func testIsTwoPair() {
        
        // 5枚・ツーペア時
        let hand_A = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .jack, suit: .diamond),
                                  Card(rank: .ace, suit: .club),
                                  Card(rank: .ace, suit: .spade)])
        XCTAssertTrue(hand_A.isTwoPair)
        
        // 5枚・フルハウス時
        let hand_B = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .three, suit: .diamond),
                                  Card(rank: .ace, suit: .club),
                                  Card(rank: .ace, suit: .spade)])
        XCTAssertFalse(hand_B.isTwoPair)
        
        // 5枚・スリーカード
        let hand_C = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .three, suit: .diamond),
                                  Card(rank: .jack, suit: .club),
                                  Card(rank: .ace, suit: .spade)])
        XCTAssertFalse(hand_C.isTwoPair)
    }
    
    func testIsThreeCard() {
        
        // 5枚・スリーカード
        let hand_A = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .three, suit: .diamond),
                                  Card(rank: .jack, suit: .club),
                                  Card(rank: .ace, suit: .spade)])
        XCTAssertTrue(hand_A.isThreeCard)
        
        // 5枚・フルハウス時
        let hand_B = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .three, suit: .diamond),
                                  Card(rank: .ace, suit: .club),
                                  Card(rank: .ace, suit: .spade)])
        XCTAssertFalse(hand_B.isThreeCard)
    }
    
    func testIsFourCard() {
        
        // 5枚・フォーカード
        let hand_A = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .three, suit: .diamond),
                                  Card(rank: .three, suit: .spade),
                                  Card(rank: .ace, suit: .spade)])
        XCTAssertTrue(hand_A.isFourCard)
        
        // 5枚・フォーカードではない
        let hand_B = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .three, suit: .diamond),
                                  Card(rank: .ace, suit: .club),
                                  Card(rank: .ace, suit: .spade)])
        XCTAssertFalse(hand_B.isFourCard)
    }
    
    func testStraight() {
        
        // 5枚・ストレート
        let hand_A = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .four, suit: .club),
                                  Card(rank: .five, suit: .diamond),
                                  Card(rank: .six, suit: .spade),
                                  Card(rank: .seven, suit: .spade)])
        XCTAssertTrue(hand_A.isStraight)
        
        // 5枚・ストレートではない
        let hand_B = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .five, suit: .diamond),
                                  Card(rank: .queen, suit: .spade),
                                  Card(rank: .seven, suit: .spade)])
        XCTAssertFalse(hand_B.isStraight)
        
        // 5枚・ストレート
        let hand_C = Hand(cards: [Card(rank: .ace, suit: .spade),
                                  Card(rank: .queen, suit: .diamond),
                                  Card(rank: .king, suit: .spade),
                                  Card(rank: .ten, suit: .heart),
                                  Card(rank: .jack, suit: .club)])
        XCTAssertTrue(hand_C.isStraight)
        
        // 5枚・ストレート
        let hand_D = Hand(cards: [Card(rank: .ace, suit: .spade),
                                  Card(rank: .three, suit: .diamond),
                                  Card(rank: .five, suit: .spade),
                                  Card(rank: .four, suit: .heart),
                                  Card(rank: .two, suit: .club)])
        XCTAssertTrue(hand_D.isStraight)
        
        // 5枚・ストレートフラッシュ
        let hand_E = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .four, suit: .heart),
                                  Card(rank: .five, suit: .heart),
                                  Card(rank: .six, suit: .heart),
                                  Card(rank: .seven, suit: .heart)])
        XCTAssertFalse(hand_E.isStraight)
        
        // 5枚・ロイヤルストレートフラッシュ
        let hand_F = Hand(cards: [Card(rank: .ace, suit: .heart),
                                  Card(rank: .king, suit: .heart),
                                  Card(rank: .ten, suit: .heart),
                                  Card(rank: .jack, suit: .heart),
                                  Card(rank: .queen, suit: .heart)])
        XCTAssertFalse(hand_F.isStraight)
    }
    
    func testIsFullHouse() {
        
        // フルハウス
        let hand_A = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .three, suit: .diamond),
                                  Card(rank: .ace, suit: .club),
                                  Card(rank: .ace, suit: .spade)])
        XCTAssertTrue(hand_A.isFullHouse)
        
        // フルハウスではない
        let hand_B = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .club),
                                  Card(rank: .three, suit: .diamond),
                                  Card(rank: .ace, suit: .club),
                                  Card(rank: .jack, suit: .spade)])
        XCTAssertFalse(hand_B.isFullHouse)
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
        
        // 5枚・ストレートフラッシュ
        let hand_G = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .four, suit: .heart),
                                  Card(rank: .five, suit: .heart),
                                  Card(rank: .six, suit: .heart),
                                  Card(rank: .seven, suit: .heart)])
        XCTAssertFalse(hand_G.isFlash)
        
        // 5枚・ロイヤルストレートフラッシュ
        let hand_H = Hand(cards: [Card(rank: .ace, suit: .heart),
                                  Card(rank: .king, suit: .heart),
                                  Card(rank: .ten, suit: .heart),
                                  Card(rank: .jack, suit: .heart),
                                  Card(rank: .queen, suit: .heart)])
        XCTAssertFalse(hand_H.isFlash)
    }
    
    func testIsStraightFlash() {
        
        // ストレートフラッシュ
        let hand_A = Hand(cards: [Card(rank: .ace, suit: .spade),
                                  Card(rank: .three, suit: .spade),
                                  Card(rank: .five, suit: .spade),
                                  Card(rank: .four, suit: .spade),
                                  Card(rank: .two, suit: .spade)])
        XCTAssertTrue(hand_A.isStraightFlash)
        
        // ストレート
        let hand_B = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .four, suit: .club),
                                  Card(rank: .five, suit: .diamond),
                                  Card(rank: .six, suit: .spade),
                                  Card(rank: .seven, suit: .spade)])
        XCTAssertFalse(hand_B.isStraightFlash)
    }
    
    func testRoyalStraightFlash() {
        
        // ロイヤルストレートフラッシュ
        let hand_A = Hand(cards: [Card(rank: .ace, suit: .spade),
                                  Card(rank: .queen, suit: .spade),
                                  Card(rank: .king, suit: .spade),
                                  Card(rank: .ten, suit: .spade),
                                  Card(rank: .jack, suit: .spade)])
        XCTAssertTrue(hand_A.isRoyalStraightFlash)
        
        // ロイヤルストレートフラッシュではない...
        let hand_B = Hand(cards: [Card(rank: .ace, suit: .spade),
                                  Card(rank: .queen, suit: .heart),
                                  Card(rank: .king, suit: .spade),
                                  Card(rank: .ten, suit: .club),
                                  Card(rank: .jack, suit: .spade)])
        XCTAssertFalse(hand_B.isRoyalStraightFlash)
    }
    
    func testIsHighCard() {
        
        let hand_A = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .ace, suit: .spade)])
        XCTAssertTrue(hand_A.isHighCard)
        
        let hand_B = Hand(cards: [Card(rank: .three, suit: .heart),
                                  Card(rank: .three, suit: .spade)])
        XCTAssertFalse(hand_B.isHighCard)
    }
    
    func testHand() {
        
        // ロイヤルストレートフラッシュ
        let cards_A = [Card(rank: .ace, suit: .spade),
                       Card(rank: .queen, suit: .spade),
                       Card(rank: .king, suit: .spade),
                       Card(rank: .ten, suit: .spade),
                       Card(rank: .jack, suit: .spade)]
        let hand_A = Hand(cards: cards_A)
        XCTAssertEqual(hand_A.hand(), .royalStraightFlash(cards: cards_A))
        
        // スリーカード
        let cards_B = [Card(rank: .ace, suit: .spade),
                       Card(rank: .ace, suit: .heart),
                       Card(rank: .ace, suit: .club),
                       Card(rank: .ten, suit: .spade),
                       Card(rank: .jack, suit: .spade)]
        let three_B = cards_B[0]
        let hand_B = Hand(cards: cards_B)
        XCTAssertEqual(hand_B.hand(), .threeCard(cards: cards_B, three: three_B))
        
        // ハイカード
        let cards_C = [Card(rank: .two, suit: .spade),
                       Card(rank: .ace, suit: .heart),
                       Card(rank: .seven, suit: .club),
                       Card(rank: .ten, suit: .spade),
                       Card(rank: .jack, suit: .spade)]
        let hand_C = Hand(cards: cards_C)
        XCTAssertEqual(hand_C.hand(), .highCard(cards: cards_C))
    }
    
    // MARK: - PokerHand
    
    func testPokerHandCompare() {
        
        // ハイカード
        let cards_A1 = [Card(rank: .two, suit: .spade),
                        Card(rank: .ace, suit: .heart),
                        Card(rank: .seven, suit: .club),
                        Card(rank: .ten, suit: .spade),
                        Card(rank: .jack, suit: .spade)]
        // ワンペア
        let cards_A2 = [Card(rank: .ace, suit: .spade),
                        Card(rank: .ace, suit: .heart),
                        Card(rank: .queen, suit: .club),
                        Card(rank: .ten, suit: .spade),
                        Card(rank: .jack, suit: .spade)]
        let pair_A2 = cards_A2[0]
        XCTAssertLessThan(PokerHand.highCard(cards: cards_A1),
                          PokerHand.onePair(cards: cards_A2, pair: pair_A2))
        
        // ロイヤルストレートフラッシュ
        let cards_B1 = [Card(rank: .ace, suit: .spade),
                        Card(rank: .queen, suit: .spade),
                        Card(rank: .king, suit: .spade),
                        Card(rank: .ten, suit: .spade),
                        Card(rank: .jack, suit: .spade)]
        // ロイヤルストレートフラッシュ
        let cards_B2 = [Card(rank: .ace, suit: .spade),
                        Card(rank: .ten, suit: .spade),
                        Card(rank: .queen, suit: .spade),
                        Card(rank: .king, suit: .spade),
                        Card(rank: .jack, suit: .spade)]
        XCTAssertGreaterThanOrEqual(PokerHand.royalStraightFlash(cards: cards_B1),
                                    PokerHand.royalStraightFlash(cards: cards_B2))
        
        // ロイヤルストレートフラッシュ
        let cards_C1 = [Card(rank: .ace, suit: .spade),
                        Card(rank: .queen, suit: .spade),
                        Card(rank: .king, suit: .spade),
                        Card(rank: .ten, suit: .spade),
                        Card(rank: .jack, suit: .spade)]
        // スリーカード
        let cards_C2 = [Card(rank: .ace, suit: .spade),
                        Card(rank: .ace, suit: .heart),
                        Card(rank: .ace, suit: .club),
                        Card(rank: .ten, suit: .spade),
                        Card(rank: .jack, suit: .spade)]
        let three_C2 = cards_C2[0]
        XCTAssertGreaterThanOrEqual(PokerHand.royalStraightFlash(cards: cards_C1),
                                    PokerHand.threeCard(cards: cards_C2, three: three_C2))
        
        // ワンペア
        let cards_D1 = [Card(rank: .three, suit: .spade),
                        Card(rank: .three, suit: .heart),
                        Card(rank: .queen, suit: .club),
                        Card(rank: .ten, suit: .spade),
                        Card(rank: .jack, suit: .spade)]
        let pair_D1 = cards_D1[0]
        // ワンペア
        let cards_D2 = [Card(rank: .ace, suit: .spade),
                        Card(rank: .ace, suit: .heart),
                        Card(rank: .queen, suit: .club),
                        Card(rank: .ten, suit: .spade),
                        Card(rank: .jack, suit: .spade)]
        let pair_D2 = cards_D2[0]
        XCTAssertLessThan(PokerHand.onePair(cards: cards_D1, pair: pair_D1),
                          PokerHand.onePair(cards: cards_D2, pair: pair_D2))
        
        // ハイカード
        let cards_E1 = [Card(rank: .two, suit: .spade),
                        Card(rank: .ace, suit: .heart),
                        Card(rank: .seven, suit: .club),
                        Card(rank: .ten, suit: .spade),
                        Card(rank: .jack, suit: .spade)]
        // ハイカード
        let cards_E2 = [Card(rank: .two, suit: .spade),
                        Card(rank: .ace, suit: .heart),
                        Card(rank: .three, suit: .club),
                        Card(rank: .seven, suit: .spade),
                        Card(rank: .jack, suit: .spade)]
        XCTAssertGreaterThan(PokerHand.highCard(cards: cards_E1),
                             PokerHand.highCard(cards: cards_E2))
        
        // ツーペア
        let cards_F1 = [Card(rank: .three, suit: .spade),
                        Card(rank: .jack, suit: .heart),
                        Card(rank: .three, suit: .club),
                        Card(rank: .ten, suit: .spade),
                        Card(rank: .jack, suit: .spade)]
        let max_F1 = cards_F1[1]
        let min_F1 = cards_F1[0]
        // ツーペア
        let cards_F2 = [Card(rank: .ace, suit: .spade),
                        Card(rank: .queen, suit: .heart),
                        Card(rank: .queen, suit: .club),
                        Card(rank: .ten, suit: .spade),
                        Card(rank: .ten, suit: .heart)]
        let max_F2 = cards_F2[1]
        let min_F2 = cards_F2[4]
        XCTAssertLessThan(PokerHand.twoPair(cards: cards_F1, pairMax: max_F1, pairMin: min_F1),
                          PokerHand.twoPair(cards: cards_F2, pairMax: max_F2, pairMin: min_F2))
    }
    
    // MARK: - Table
    
    func testRanking() {
        
        // ロイヤルストレートフラッシュ
        let cards_A = [Card(rank: .ace, suit: .spade),
                       Card(rank: .queen, suit: .spade),
                       Card(rank: .king, suit: .spade),
                       Card(rank: .ten, suit: .spade),
                       Card(rank: .jack, suit: .spade)]
        let hand_Alice = Hand(cards: cards_A, name: "Alice")
        // ハイカード
        let cards_B = [Card(rank: .two, suit: .spade),
                       Card(rank: .ace, suit: .heart),
                       Card(rank: .seven, suit: .club),
                       Card(rank: .ten, suit: .spade),
                       Card(rank: .jack, suit: .spade)]
        let hand_Bob = Hand(cards: cards_B, name: "Bob")
        // スリーカード
        let cards_C = [Card(rank: .ace, suit: .spade),
                       Card(rank: .ace, suit: .heart),
                       Card(rank: .ace, suit: .club),
                       Card(rank: .ten, suit: .spade),
                       Card(rank: .jack, suit: .spade)]
        let hand_Carol = Hand(cards: cards_C, name: "Carol")
        let table1 = Table(hands: [hand_Alice, hand_Bob, hand_Carol])
        XCTAssertEqual(table1.ranking, [["Alice"], ["Carol"], ["Bob"]])
        
        // ワンペア
        let cards_D = [Card(rank: .ace, suit: .spade),
                       Card(rank: .ace, suit: .heart),
                       Card(rank: .king, suit: .spade),
                       Card(rank: .ten, suit: .spade),
                       Card(rank: .jack, suit: .spade)]
        let hand_Dave = Hand(cards: cards_D, name: "Dave")
        // ワンペア
        let cards_E = [Card(rank: .ace, suit: .diamond),
                       Card(rank: .ten, suit: .club),
                       Card(rank: .king, suit: .heart),
                       Card(rank: .ace, suit: .club),
                       Card(rank: .jack, suit: .diamond)]
        let hand_Ellen = Hand(cards: cards_E, name: "Ellen")
        let table2 = Table(hands: [hand_Dave, hand_Ellen])
        XCTAssertEqual(table2.ranking, [["Dave", "Ellen"]])
    }
    
    // MARK: - Dealer
    
    func testDealCards() {
        
        let dealer = Dealer()
        let cards = dealer.dealCards(5)
        // 頼んだ枚数を配布している
        XCTAssertEqual(cards.count, 5)
        // 同じカードを複数枚配布していない
        XCTAssertEqual(Set(cards).count, 5)
    }
}
