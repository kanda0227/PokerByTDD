//
//  WalletView.swift
//  Design
//
//  Created by Kanda Sena on 2018/12/13.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model
import Utility

@IBDesignable public final class WalletView: CustomView {
    
    @IBOutlet private weak var walletLabel: CustomLabel!
    @IBOutlet private weak var itemNameLabel: CustomLabel!
    @IBOutlet private weak var recoveryLabel: CustomLabel!
    
    @IBInspectable public var money: Int = 10000 {
        didSet {
            walletLabel?.text = "\(money)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func instantiate() -> UIView {
        return UINib(nibName: "WalletView", bundle: Bundle(for: WalletView.self))
            .instantiate(withOwner: self, options: nil)
            .first as! UIView
    }
    
    // イニシャライザの共通処理
    private func configure() {
        let view = instantiate()
        view.frame = bounds
        self.addSubview(view)
        backgroundColor = .clear
    }
    
    public func set(colorSet: ColorSet) {
        walletLabel.textColor = colorSet.textColor()
        itemNameLabel.textColor = colorSet.textColor()
        recoveryLabel.textColor = colorSet.textColor()
    }
    
    override public var intrinsicContentSize: CGSize {
        let walletLabelSize = walletLabel.intrinsicContentSize
        let itemNameLabelSize = itemNameLabel.intrinsicContentSize
        let recoveryLabelSize = recoveryLabel.intrinsicContentSize
        return CGSize(width: walletLabelSize.width + itemNameLabelSize.width + recoveryLabelSize.width, height: walletLabelSize.height)
    }
    
    public func set(second: Int, presentMoneyPerTime: Int, shouldPresentMoney: Bool) {
        recoveryLabel.text = recoveryText(second: second, presentMoneyPerTime: presentMoneyPerTime, shouldPresentMoney: shouldPresentMoney)
        invalidateIntrinsicContentSize()
    }
    
    private func recoveryText(second: Int, presentMoneyPerTime: Int, shouldPresentMoney: Bool) -> String {
        if shouldPresentMoney {
            return "あと\(second)秒で\(presentMoneyPerTime)円あげるにゃ　"
        } else {
            return "お金が無くなってきたらまたあげるにゃ　"
        }
    }
}
