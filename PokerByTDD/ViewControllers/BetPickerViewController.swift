//
//  BetPickerViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/26.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

// MARK: - BetPickerViewController

/// 賭け金選択画面
final class BetPickerViewController: UIViewController {
    
    /// この画面を閉じる際に実行するクロージャ
    private var completion: ((_ bet: Int) -> ())?
    /// 所持金
    private var possessionMoney: Int!
    
    private lazy var presenter = BetPickerPresenter()
    
    @IBOutlet private weak var mainView: UIView! {
        didSet {
            mainView.layer.borderColor = UIColor(named: "pink")?.cgColor
            mainView.layer.borderWidth = 5
            mainView.layer.cornerRadius = 7
        }
    }
    /// 賭けたい金額を表示するためのラベル
    @IBOutlet private weak var betLabel: UILabel!
    /// 賭け金選択用のピッカー
    @IBOutlet private weak var picker: UIPickerView! {
        didSet {
            picker.dataSource = self
            picker.delegate = self
        }
    }
    /// 完了ボタン
    @IBOutlet private weak var doneButton: UIButton!
    
    /// ファクトリーメソッド
    ///
    /// - Parameters:
    ///     - possessionMoney: 所持金を渡してください．
    ///     - post: 画面を閉じる際に呼ばれるクロージャです．賭ける金額を引数にしてください．
    static func instantiate(possessionMoney: Int, post: @escaping (_ bet: Int) -> ()) -> BetPickerViewController {
        
        let vc = UIStoryboard(name: "BetPickerView", bundle: nil).instantiateInitialViewController() as! BetPickerViewController
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        vc.completion = post
        vc.possessionMoney = possessionMoney
        return vc
    }
    
    @IBAction private func doneButton(_ sender: Any) {
        let bet = betLabel.text.flatMap(Int.init) ?? 0
        completion?(bet)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDataSource

extension BetPickerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return presenter.numberOfComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.numberOfRowsInComponent(component)
    }
}

// MARK: - UIPickerViewDelegate

extension BetPickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedNum = 0
        for i in 0..<numberOfComponents(in: pickerView) {
            let rowNum = component == i ? row : pickerView.selectedRow(inComponent: i)
            selectedNum += (rowNum * placeNum(component: i))
        }
        
        doneButton.isEnabled = selectedNum <= possessionMoney
        betLabel.text = doneButton.isEnabled ? "\(selectedNum)" : "所持金を超えているようです"
    }
    
    private func placeNum(component: Int) -> Int {
        let componentCount = numberOfComponents(in: picker)
        return Int(pow(10, Double(componentCount - component - 1)))
    }
}
