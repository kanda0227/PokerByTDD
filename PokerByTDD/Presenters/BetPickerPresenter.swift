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
    
    private var pickerValue: [Int] {
        didSet {
            selectedValue = pickerValue.reversed().enumerated().map { $0.element * placeNum($0.offset) }.reduce(0, +)
        }
    }
    
    private var selectedValue = 0
    
    /// 所持金
    private var possessionMoney: Int
    
    init(possessionMoney: Int) {
        self.possessionMoney = possessionMoney
        pickerValue = [Int](repeating: 0, count: componentsNum)
    }

    func isDoneButtonEnabled() -> Bool {
        return isInRangeValue()
    }
    
    func betText() -> String {
        return isInRangeValue() ? "\(selectedValue)" : "所持金を超えているようです"
    }
    
    func betValue() -> Int {
        // 不正な値の場合は0を返しておく
        guard isInRangeValue() else { return 0 }
        return selectedValue
    }
    
    private func isInRangeValue() -> Bool {
        return selectedValue <= possessionMoney
    }
    
    // MARK: - Picker
    
    func numberOfComponents() -> Int {
        return componentsNum
    }
    
    func numberOfRowsInComponent(_ component: Int) -> Int {
        return rowsInComponentNum
    }
    
    func titleForRow(_ row: Int, component: Int) -> String? {
        return "\(row)"
    }
    
    func didSelectRow(_ row: Int, component: Int) {
        pickerValue[component] = row
    }
    
    private func placeNum(_ n: Int) -> Int {
        return Int(pow(10, Double(n)))
    }
}
