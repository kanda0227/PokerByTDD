//
//  ColorSettingPresenter.swift
//  Presenter
//
//  Created by Kanda Sena on 2018/12/15.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import Model

public final class ColorSettingPresenter {
    
    private let items = ColorSet.allCases
    
    public init() {}
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        return items.count
    }
    
    public func item(at indexPath: IndexPath) -> ColorSet {
        return items[indexPath.row]
    }
    
    public func didSelect(at indexPath: IndexPath) {
        item(at: indexPath).save()
    }
}
