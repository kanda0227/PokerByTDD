//
//  SettingPresenter.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

public final class SettingPresenter {
    
    public typealias Item = (itemName: String, storyboardID: String)
    
    private let items: [Item] = [
        ("カードデザイン設定", "CardDesignView"),
        ("カラーテーマ設定", "ColorSettingView"),
        ("音設定", "AudioSettingView")
    ]
    
    public init() {}
    
    public func numberOfRowsInSection() -> Int {
        return items.count
    }
    
    public func item(at indexPath: IndexPath) -> Item {
        return items[indexPath.row]
    }
}
