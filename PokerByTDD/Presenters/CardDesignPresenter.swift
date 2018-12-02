//
//  CardDesignPresenter.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

final class CardDesignPresenter {
    
    private let items: [CardDesignCategory] = CardDesignCategory.allCases
    
    func numberOfRowsInSection() -> Int {
        return items.count
    }
    
    func item(at indexPath: IndexPath) -> CardDesignCategory {
        return items[indexPath.row]
    }
}

enum CardDesignCategory: String, CaseIterable {
    case back = "カードの柄を変更する"
}
