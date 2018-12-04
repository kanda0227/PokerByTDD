//
//  BetPickerViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/26.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Presenter

// MARK: - BetPickerViewController

/// 賭け金選択画面
final class BetPickerViewController: UIViewController {
    
    /// この画面を閉じる際に実行するクロージャ
    private var completion: ((_ bet: Int) -> ())?
    
    private var presenter: BetPickerPresenter!
    
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
        vc.presenter = BetPickerPresenter(
            possessionMoney: possessionMoney,
            betLabelText: vc.betLabelText,
            switchIsDoneButtonEnabled: vc.switchIsDoneButtonEnabled)
        return vc
    }
    
    @IBAction private func tapDoneButton(_ sender: Any) {
        completion?(presenter.betValue())
        dismiss(animated: true, completion: nil)
    }
    
    private var betLabelText: Binder<String?> {
        return Binder(self) { _self, text in
            _self.betLabel?.text = text
        }
    }
    
    private var switchIsDoneButtonEnabled: Binder<Bool> {
        return Binder(self) { _self, isEnabled in
            _self.doneButton?.isEnabled = isEnabled
        }
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
        return presenter.titleForRow(row, component: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.didSelectRow(row, component: component)
    }
}
