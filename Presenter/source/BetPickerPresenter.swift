//
//  BetPickerPresenter.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/28.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public final class BetPickerPresenter {
    
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
    
    private let betLabelText: Binder<String?>
    private let switchIsDoneButtonEnabled: Binder<Bool>
    
    public init(possessionMoney: Int,
         betLabelText: Binder<String?>,
         switchIsDoneButtonEnabled: Binder<Bool>) {
        self.possessionMoney = possessionMoney
        self.betLabelText = betLabelText
        self.switchIsDoneButtonEnabled = switchIsDoneButtonEnabled
        pickerValue = [Int](repeating: 0, count: componentsNum)
    }
    
    private func betText() -> String {
        return isInRangeValue() ? "\(selectedValue)" : "所持金を超えているようです"
    }
    
    public func betValue() -> Int {
        // 不正な値の場合は0を返しておく
        guard isInRangeValue() else { return 0 }
        return selectedValue
    }
    
    private func isInRangeValue() -> Bool {
        return selectedValue <= possessionMoney
    }
    
    // MARK: - Picker
    
    public func numberOfComponents() -> Int {
        return componentsNum
    }
    
    public func numberOfRowsInComponent(_ component: Int) -> Int {
        return rowsInComponentNum
    }
    
    public func titleForRow(_ row: Int, component: Int) -> String? {
        return "\(row)"
    }
    
    public func didSelectRow(_ row: Int, component: Int) {
        pickerValue[component] = row
        betLabelText.onNext(betText())
        switchIsDoneButtonEnabled.onNext(isInRangeValue())
    }
    
    /// n 桁目の位を計算します
    private func placeNum(_ n: Int) -> Int {
        return Int(pow(10, Double(n)))
    }
}
