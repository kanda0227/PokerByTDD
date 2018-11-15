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
    
    enum Suit {
        /// ハート
        case heart
        /// スペード
        case spade
        /// クラブ
        case club
        /// ダイヤ
        case diamond
    }
    
    enum Rank {
        /// エース
        case ace
        /// 2
        case two
        /// 3
        case three
        /// 4
        case four
        /// 5
        case five
        /// 6
        case six
        /// 7
        case seven
        /// 8
        case eight
        /// 9
        case nine
        /// 10
        case ten
        /// ジャック
        case jack
        /// クイーン
        case queen
        /// キング
        case king
    }
    
    let suit: Suit
    let rank: Rank
    
    var notation: String {
        return "3♥"
    }
}
