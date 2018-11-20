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
struct Card: Hashable {
    
    // 定義順は弱い順においてね
    enum Rank: String, CaseIterable {
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
        /// エース
        case ace = "A"
        
        var stlength: Int {
            // 強さレベルを定義順に依存させる
            // allCases は定義順通りに取得できる
            return Rank.allCases.firstIndex(of: self)!
        }
    }
    
    enum Suit: String, CaseIterable {
        /// ハート
        case heart = "♥"
        /// スペード
        case spade = "♠︎"
        /// クラブ
        case club = "♣︎"
        /// ダイヤ
        case diamond = "♦︎"
    }
    
    let rank: Rank
    let suit: Suit
    
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
    
    /// デフォルトでとりあえずカードが欲しい時に渡す用の定数
    static let defaultCard = Card(rank: .ace, suit: .club)
}

// MARK: - Equatable

extension Card: Equatable {
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.hasSameRank(rhs) && lhs.hasSameSuit(rhs)
    }
}

// MARK: - Comparable

extension Card: Comparable {
    
    static func <(lhs: Card, rhs: Card) -> Bool {
        return lhs.rank.stlength < rhs.rank.stlength
    }
}
