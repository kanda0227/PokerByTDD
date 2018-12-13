//
//  WalletView.swift
//  Design
//
//  Created by Kanda Sena on 2018/12/13.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

@IBDesignable public final class WalletView: UIView {
    
    @IBOutlet private weak var walletLabel: UILabel!
    @IBOutlet private weak var itemNameLabel: UILabel!
    
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
    }
    
    override public var intrinsicContentSize: CGSize {
        let walletLabelSize = walletLabel.bounds.size
        let itemNameLabelSize = itemNameLabel.bounds.size
        return CGSize(width: walletLabelSize.width + itemNameLabelSize.width, height: walletLabelSize.height)
    }
}
