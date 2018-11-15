//
//  Card.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/15.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

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
    
    let rank: Rank
    let suit: Suit
    
    /// 文字列表記
    var notation: String {
        return rank.rawValue + suit.rawValue
    }
    
    func hasSameRank(_ card: Card) -> Bool {
        return true
    }
}
