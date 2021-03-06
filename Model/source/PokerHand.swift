//
//  PokerHand.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/17.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

/// ポーカーの役一覧
/// 弱い順に並べくださいね
public enum PokerHand {
    
    typealias Rank = Card.Rank
    
    case highCard(cards: [Card])
    case onePair(cards: [Card], pair: Card)
    case twoPair(cards: [Card], pairMax: Card, pairMin: Card)
    case threeCard(cards: [Card], three: Card)
    case straight(cards: [Card])
    case flash(cards: [Card])
    case fullHouse(cards: [Card], three: Card, two: Card)
    case fourCard(cards: [Card], four: Card)
    case straightFlash(cards: [Card])
    case royalStraightFlash(cards: [Card]) // ぶっちゃけカードいらないんだけど統一性と， suit で優先度をつける仕様変更を考慮して追加しておく
    
    // 一部の引数が必要な case について，
    // 役だけを見たい場合に使用するためのデフォルト値入り case を用意
    // 同じカードを使用したり，カードが空だったりしますが
    // あくまで役の列挙に使用しているため許容します
    /// デフォルト値入りのハイカード定数
    static let defaultHighCard = PokerHand.highCard(cards: [])
    /// デフォルト値入りのワンペア定数
    static let defaultOnePair = PokerHand.onePair(cards: [], pair: .defaultCard)
    /// デフォルト値入りのツーペア定数
    static let defaultTwoPair = PokerHand.twoPair(cards: [], pairMax: .defaultCard, pairMin: .defaultCard)
    /// デフォルト値入りのスリーカード定数
    static let defaultThreeCard = PokerHand.threeCard(cards: [], three: .defaultCard)
    /// デフォルト値入りのストレート定数
    static let defaultStraight = PokerHand.straight(cards: [])
    /// デフォルト値入りのフラッシュ定数
    static let defaultFlash = PokerHand.flash(cards: [])
    /// デフォルト値入りのフルハウス定数
    static let defaultFullHouse = PokerHand.fullHouse(cards: [], three: .defaultCard, two: .defaultCard)
    /// デフォルト値入りのフォーカード定数
    static let defaultFourCard = PokerHand.fourCard(cards: [], four: .defaultCard)
    /// デフォルト値入りのストレートフラッシュ定数
    static let defaultStraightFlash = PokerHand.straightFlash(cards: [])
    /// デフォルト値入りのロイヤルストレートフラッシュ定数
    static let defaultRoyalStraightFlash = PokerHand.royalStraightFlash(cards: [])
    
    /// 一部引数が必要になってしまうものはデフォルト値を入れたものを使用
    static var allCases: [PokerHand]
        = [.defaultHighCard,
           .defaultOnePair,
           .defaultTwoPair,
           .defaultThreeCard,
           .defaultStraight,
           .defaultFlash,
           .defaultFullHouse,
           .defaultFourCard,
           .defaultStraightFlash,
           .defaultRoyalStraightFlash]
    
    var stlength: Int {
        switch self {
        case .highCard:
            return 0
        case .onePair:
            return 1
        case .twoPair:
            return 2
        case .threeCard:
            return 5
        case .straight:
            return 10
        case .flash:
            return 15
        case .fullHouse:
            return 20
        case .fourCard:
            return 30
        case .straightFlash:
            return 40
        case .royalStraightFlash:
            return 50
        }
    }
    
    public var text: String {
        switch self {
        case .highCard:
            return "ハイカード"
        case .onePair:
            return "ワンペア"
        case .twoPair:
            return "ツーペア"
        case .threeCard:
            return "スリーカード"
        case .straight:
            return "ストレート"
        case .flash:
            return "フラッシュ"
        case .fullHouse:
            return "フルハウス"
        case .fourCard:
            return "フォーカード"
        case .straightFlash:
            return "ストレートフラッシュ"
        case .royalStraightFlash:
            return "ロイヤルストレートフラッシュ"
        }
    }
}

extension PokerHand {
    func sameHand(_ hand: PokerHand) -> Bool {
        switch (self, hand) {
        case (.highCard, .highCard):
            return true
        case (.onePair(_), .onePair(_)):
            return true
        case (.twoPair(_), .twoPair(_)):
            return true
        case (.threeCard(_), .threeCard(_)):
            return true
        case (.straight, .straight):
            return true
        case (.flash, .flash):
            return true
        case (.fullHouse(_), .fullHouse(_)):
            return true
        case (.fourCard(_), .fourCard(_)):
            return true
        case (.straightFlash, .straightFlash):
            return true
        case (.royalStraightFlash, .royalStraightFlash):
            return true
        default:
            return false
        }
    }
    
    private var cards: [Card] {
        switch self {
        case .highCard(let cards):
            return cards
        case .onePair(let cards, _):
            return cards
        case .twoPair(let cards, _, _):
            return cards
        case .threeCard(let cards, _):
            return cards
        case .straight(let cards):
            return cards
        case .flash(let cards):
            return cards
        case .fullHouse(let cards, _, _):
            return cards
        case .fourCard(let cards, _):
            return cards
        case .straightFlash(let cards):
            return cards
        case .royalStraightFlash(let cards):
            return cards
        }
    }
}

extension PokerHand: Equatable {
    public static func == (lhs: PokerHand, rhs: PokerHand) -> Bool {
        switch (lhs, rhs) {
        case (_, _) where !lhs.sameHand(rhs):
            return false
        case (_, _):
            return isSameRanksCards(lhs.cards, rhs.cards)
        }
    }
    
    private static func isSameRanksCards(_ lCards: [Card], _ rCards: [Card]) -> Bool {
        let rCards = rCards.sorted()
        return lCards.sorted().enumerated().map { index, card in
            rCards[index].hasSameRank(card)
            }.filter { !$0 }.isEmpty
    }
}

extension PokerHand: Comparable {
    
    public static func < (lhs: PokerHand, rhs: PokerHand) -> Bool {
        switch (lhs, rhs) {
            
        case (_, _) where !lhs.sameHand(rhs):
            return lhs.stlength < rhs.stlength
            
        case (.highCard(let lCards), .highCard(let rCards)):
            return lKickerLessThanRKicker(lCards, rCards)
            
        case (.onePair(let lCards, let lPair), .onePair(let rCards, pair: let rPair)):
            let equalPair = lPair == rPair
            return equalPair
                ? lKickerLessThanRKicker(lCards, rCards)
                : lPair < rPair
            
        case (.twoPair(let lCards, let lMax, let lMin), .twoPair(let rCards, let rMax, let rMin)):
            let equalMax = lMax == rMax
            let equalMin = lMin == rMin
            return equalMax
                ? equalMin
                    ? lKickerLessThanRKicker(lCards, rCards)
                    : lMin < rMin
                : lMax < rMax
            
        case (.threeCard(let lCards, let lThree), .threeCard(let rCards, let rThree)):
            let equalThree = lThree == rThree
            return equalThree
                ? lKickerLessThanRKicker(lCards, rCards)
                : lThree < rThree
            
        case (.straight(let lCards), .straight(let rCards)):
            return lKickerLessThanRKicker(lCards, rCards)
            
        case (.flash(let lCards), .flash(let rCards)):
            return lKickerLessThanRKicker(lCards, rCards)
            
        case (.fullHouse(let lCards, let lThree, let lPair), .fullHouse(let rCards, let rThree, let rPair)):
            let equalThreeCard = lThree == rThree
            let equalPair = lPair == rPair
            return equalThreeCard
                ? equalPair
                    ? lKickerLessThanRKicker(lCards, rCards)
                    : lPair < rPair
                : lThree < rThree
            
        case (.fourCard(let lCards, let lFour), .fourCard(let rCards, let rFour)):
            let equalFour = lFour == rFour
            return equalFour
                ? lKickerLessThanRKicker(lCards, rCards)
                : lFour < rFour
            
        case (.straightFlash(let lCards), .straightFlash(let rCards)):
            return lKickerLessThanRKicker(lCards, rCards)
            
        case (.royalStraightFlash, _):
            // ここはどうあがいても同じなので省略
            return false
            
        default:
            // ここには来ないはず
            return false
        }
    }
    
    private static func lKickerLessThanRKicker(_ lCards: [Card], _ rCards: [Card]) -> Bool {
        guard let index = differentIndex(lCards.sorted { $0 > $1 }, rCards.sorted { $0 > $1 }) else { return false }
        return lCards[index] < rCards[index]
    }
    
    private static func differentIndex(_ lCards: [Card], _ rCards: [Card]) -> Int? {
        guard lCards.count == rCards.count else { return nil }
        return lCards.enumerated().filter { !($0.element == rCards[$0.offset]) }.first?.offset
    }
}
