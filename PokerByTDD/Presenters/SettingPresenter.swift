//
//  SettingPresenter.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

final class SettingPresenter {
    
    typealias Item = (itemName: String, storyboardID: String)
    
    private let items: [Item] = [
        ("カードデザイン設定", "CardDesignView")
    ]
    
    init() {}
    
    func numberOfRowsInSection() -> Int {
        return items.count
    }
    
    func item(at indexPath: IndexPath) -> Item {
        return items[indexPath.row]
    }
}
