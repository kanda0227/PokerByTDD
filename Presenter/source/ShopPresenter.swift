//
//  ShopPresenter.swift
//  Presenter
//
//  Created by Kanda Sena on 2018/12/31.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

public final class ShopPresenter {
    
    public typealias Item = (name: String, image: UIImage)
    
    private let items: [Item] = [
        ("ごはん", #imageLiteral(resourceName: "ic_meal")),
        ("おもちゃ", #imageLiteral(resourceName: "ic_toy"))
    ]
    
    public init() {}
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    public func numberOfItemsInSection(_ section: Int) -> Int {
        return items.count
    }
    
    public func item(at indexPath: IndexPath) -> Item {
        return items[indexPath.item]
    }
}
