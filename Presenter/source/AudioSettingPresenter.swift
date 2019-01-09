//
//  AudioSettingPresenter.swift
//  Presenter
//
//  Created by Kanda Sena on 2019/01/09.
//  Copyright © 2019 sena.kanda. All rights reserved.
//

import Foundation
import Model

public final class AudioSettingPresenter {
    
    private let items = MusicAudio.allCases
    
    public init() {}
    
    public func numberOfComponents() -> Int {
        return 1
    }
    
    public func numberOfRowsInComponent(_ component: Int) -> Int {
        return items.count
    }
    
    public func title(row: Int, component: Int) -> String? {
        return items[row].musicName()
    }
    
    public func selected() -> (row: Int, component: Int) {
        let row = items.firstIndex(of: AudioHelper.shared.currentMusic()) ?? 0
        return (row, 0)
    }
}
