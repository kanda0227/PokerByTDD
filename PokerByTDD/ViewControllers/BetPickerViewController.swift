//
//  BetPickerViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/26.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

final class BetPickerViewController: UIViewController {
    
    static func instantiate(possessionMoney: Int, post: @escaping (_ bet: Int) -> ()) -> BetPickerViewController {
        let vc = UIStoryboard(name: "BetPickerView", bundle: nil).instantiateInitialViewController() as! BetPickerViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.completion = post
        vc.possessionMoney = possessionMoney
        return vc
    }
    
    private var completion: ((_ bet: Int) -> ())?
    private var possessionMoney: Int!
    
    @IBOutlet private weak var mainView: UIView! {
        didSet {
            mainView.layer.borderColor = UIColor(named: "pink")?.cgColor
            mainView.layer.borderWidth = 5
            mainView.layer.cornerRadius = 7
        }
    }
    @IBOutlet private weak var betLabel: UILabel!
    @IBOutlet private weak var picker: UIPickerView! {
        didSet {
            picker.dataSource = self
            picker.delegate = self
        }
    }
    
    @IBAction private func doneButton(_ sender: Any) {
        let bet = betLabel.text.flatMap(Int.init) ?? 0
        completion?(bet)
        dismiss(animated: true, completion: nil)
    }
}

extension BetPickerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}

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
        betLabel.text = "\(selectedNum)"
    }
    
    private func placeNum(component: Int) -> Int {
        let componentCount = numberOfComponents(in: picker)
        return Int(pow(10, Double(componentCount - component - 1)))
    }
}
