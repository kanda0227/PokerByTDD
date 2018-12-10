//
//  NekoLibraryPresenter.swift
//  Presenter
//
//  Created by Kanda Sena on 2018/12/11.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import Model

public final class NekoLibraryPresenter {
    
    public init() {}
    
    private let nekos = Neko.allCases
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    public func numberOfItemsInSection(_ section: Int) -> Int {
        return nekos.count
    }
    
    public func neko(at indexPath: IndexPath) -> Neko {
        return nekos[indexPath.item]
    }
}
