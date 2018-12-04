//
//  CardDesignPresenter.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import Model

public final class CardDesignPresenter {
    
    public init() {}
    
    private let items: [CardDesignCategory] = CardDesignCategory.allCases
    
    public func numberOfRowsInSection() -> Int {
        return items.count
    }
    
    public func item(at indexPath: IndexPath) -> CardDesignCategory {
        return items[indexPath.row]
    }
}

// TODO: ここもうちょっとスマートにしたいな
public enum CardDesignCategory: String, CaseIterable {
    case back = "カードの柄を変更する"
    case ace = "Aのカード全部の画像を変更する"
    case jack = "Jのカード全部の画像を変更する"
    case queen = "Qのカード全部の画像を変更する"
    case king = "Kのカード全部の画像を変更する"
    case heartAce = "A♥のカードの画像を変更する"
    case heartJack = "J♥のカードの画像を変更する"
    case heartQueen = "Q♥のカードの画像を変更する"
    case heartKing = "K♥のカードの画像を変更する"
    case spadeAce = "A♠︎のカードの画像を変更する"
    case spadeJack = "J♠︎のカードの画像を変更する"
    case spadeQueen = "Q♠︎のカードの画像を変更する"
    case spadeKing = "K♠︎のカードの画像を変更する"
    case clubAce = "A♣︎のカードの画像を変更する"
    case clubJack = "J♣︎のカードの画像を変更する"
    case clubQueen = "Q♣︎のカードの画像を変更する"
    case clubKing = "K♣︎のカードの画像を変更する"
    case diamondAce = "A♦︎のカードの画像を変更する"
    case diamondJack = "J♦︎のカードの画像を変更する"
    case diamondQueen = "Q♦︎のカードの画像を変更する"
    case diamondKing = "K♦︎のカードの画像を変更する"
    
    public func key() -> String {
        switch self {
        case .back:
            return "CardBackImageKey"
        case .ace:
            return "CardAceImageKey"
        case .jack:
            return "CardJackImageKey"
        case .queen:
            return "CardQueenImageKey"
        case .king:
            return "CardKingImageKey"
        case .heartAce:
            return "CardHeartAceImageKey"
        case .heartJack:
            return "CardHeartJackImageKey"
        case .heartQueen:
            return "CardHeartQueenImageKey"
        case .heartKing:
            return "CardHeartKingImageKey"
        case .spadeAce:
            return "CardSpadeAceImageKey"
        case .spadeJack:
            return "CardSpadeJackImageKey"
        case .spadeQueen:
            return "CardSpadeQueenImageKey"
        case .spadeKing:
            return "CardClubKingImageKey"
        case .clubAce:
            return "CardClubAceImageKey"
        case .clubJack:
            return "CardClubJackImageKey"
        case .clubQueen:
            return "CardClubQueenImageKey"
        case .clubKing:
            return "CardClubKingImageKey"
        case .diamondAce:
            return "CardDiamondAceImageKey"
        case .diamondJack:
            return "CardDiamondJackImageKey"
        case .diamondQueen:
            return "CardDiamondQueenImageKey"
        case .diamondKing:
            return "CardDiamondKingImageKey"
        }
    }
}

extension Card {
    
    /// カードのカテゴリを返します
    ///
    /// 複数当てはまることがあるため，優先度の高い順に並べています
    public var category: [CardDesignCategory] {
        switch (rank, suit) {
        case (.ace, .heart):
            return [.heartAce, .ace]
        case (.jack, .heart):
            return [.heartJack, .jack]
        case (.queen, .heart):
            return [.heartQueen, .queen]
        case (.king, .heart):
            return [.heartKing, .king]
        case (.ace, .spade):
            return [.spadeAce, .ace]
        case (.jack, .spade):
            return [.spadeJack, .jack]
        case (.queen, .spade):
            return [.spadeQueen, .queen]
        case (.king, .spade):
            return [.spadeKing, .king]
        case (.ace, .club):
            return [.clubAce, .ace]
        case (.jack, .club):
            return [.clubJack, .jack]
        case (.queen, .club):
            return [.clubQueen, .queen]
        case (.king, .club):
            return [.clubKing, .king]
        case (.ace, .diamond):
            return [.diamondAce, .ace]
        case (.jack, .diamond):
            return [.diamondJack, .jack]
        case (.queen, .diamond):
            return [.diamondQueen, .queen]
        case (.king, .diamond):
            return [.diamondKing, .king]
        default:
            return []
        }
    }
}
