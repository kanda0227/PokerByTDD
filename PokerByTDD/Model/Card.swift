//
//  Card.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/15.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

// MARK: - Card

/// トランプのカード
struct Card {
    
    enum Rank: String {
        /// エース
        case ace = "A"
        /// 2
        case two = "2"
        /// 3
        case three = "3"
        /// 4
        case four = "4"
        /// 5
        case five = "5"
        /// 6
        case six = "6"
        /// 7
        case seven = "7"
        /// 8
        case eight = "8"
        /// 9
        case nine = "9"
        /// 10
        case ten = "10"
        /// ジャック
        case jack = "J"
        /// クイーン
        case queen = "Q"
        /// キング
        case king = "K"
        
        var stlength: Int {
            switch self {
            case .ace:
                return 1000
            case .two:
                return 20
            case .three:
                return 30
            case .four:
                return 40
            case .five:
                return 50
            case .six:
                return 60
            case .seven:
                return 70
            case .eight:
                return 80
            case .nine:
                return 90
            case .ten:
                return 100
            case .jack:
                return 110
            case .queen:
                return 120
            case .king:
                return 130
            }
        }
    }
    
    enum Suit: String {
        /// ハート
        case heart = "♥"
        /// スペード
        case spade = "♠︎"
        /// クラブ
        case club = "♣︎"
        /// ダイヤ
        case diamond = "♦︎"
    }
    
    private let rank: Rank
    private let suit: Suit
    
    init(rank: Rank, suit: Suit) {
        self.rank = rank
        self.suit = suit
    }
    
    /// 文字列表記
    var notation: String {
        return rank.rawValue + suit.rawValue
    }
    
    func hasSameRank(_ card: Card) -> Bool {
        return rank == card.rank
    }
    
    func hasSameSuit(_ card: Card) -> Bool {
        return suit == card.suit
    }
}

// MARK: - Equatable

extension Card: Equatable {
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.hasSameRank(rhs)
    }
}

// MARK: - Comparable

extension Card: Comparable {
    
    static func <(lhs: Card, rhs: Card) -> Bool {
        return lhs.rank.stlength < rhs.rank.stlength
    }
}
