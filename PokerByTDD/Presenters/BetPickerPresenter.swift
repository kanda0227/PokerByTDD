//
//  BetPickerPresenter.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/28.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

final class BetPickerPresenter {
    
    private let componentsNum = 3
    private let rowsInComponentNum = 10
    
    func numberOfComponents() -> Int {
        return componentsNum
    }
    
    func numberOfRowsInComponent(_ component: Int) -> Int {
        return rowsInComponentNum
    }
}
