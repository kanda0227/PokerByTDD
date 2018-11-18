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
enum PokerHand {
    
    typealias Rank = Card.Rank
    
    case highCard
    case onePair(pair: Rank)
    case twoPair(pairMax: Rank, pairMin: Rank)
    case threeCard(three: Rank)
    case straight
    case flash
    case fullHouse(three: Rank, two: Rank)
    case fourCard(four: Rank)
    case straightFlash
    case royalStraightFlash
    
    // 一部の引数が必要な case について，
    // 役だけを見たい場合に使用するためのデフォルト値入り case を用意
    /// デフォルト値入りのワンペア定数
    static let defaultOnePair = PokerHand.onePair(pair: .ace)
    /// デフォルト値入りのツーペア定数
    static let defaultTwoPair = PokerHand.twoPair(pairMax: .ace, pairMin: .two)
    /// デフォルト値入りのスリーカード定数
    static let defaultThreeCard = PokerHand.threeCard(three: .ace)
    /// デフォルト値入りのフルハウス定数
    static let defaultFullHouse = PokerHand.fullHouse(three: .ace, two: .two)
    /// デフォルト値入りのフォーカード定数
    static let defaultFourCard = PokerHand.fourCard(four: .four)
    
    /// 一部引数が必要になってしまうものはデフォルト値を入れたものを使用
    static var allCases: [PokerHand]
        = [.highCard,
           .defaultOnePair,
           .defaultTwoPair,
           .defaultThreeCard,
           .straight,
           .flash,
           .defaultFullHouse,
           .defaultFourCard,
           .straightFlash,
           .royalStraightFlash]
    
    private var stlength: Int {
        // 定義順に依存させる
        // allCases は定義順に取得させること
        // 必ず何かしらに該当するはずなので強制アンラップ
        return PokerHand.allCases.enumerated().filter { $0.element.sameHand(self) }.map { $0.offset }.first!
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
}

extension PokerHand: Comparable {
    
    static func < (lhs: PokerHand, rhs: PokerHand) -> Bool {
        return lhs.stlength < rhs.stlength
    }
}
