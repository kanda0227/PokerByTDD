//
//  CommonDesignButton.swift
//  Design
//
//  Created by Kanda Sena on 2019/01/06.
//  Copyright © 2019 sena.kanda. All rights reserved.
//

import UIKit
import Model

@IBDesignable public final class CommonDesignButton: CustomButton {
    
    override func configure() {
        super.configure()
        setAlpha()
    }
    
    override func setColorSet() {
        backgroundColor = colorSet.navigationBarColor()
        layer.cornerRadius = 5
        
        guard let text = titleLabel?.text else { return }
        let attributedText = NSAttributedString(string: text,
                                                attributes: [.font : UIFont.boldSystemFont(ofSize: 15),
                                                             .foregroundColor : colorSet.backgroundColor()])
        setAttributedTitle(attributedText, for: .normal)
    }
    
    public override var intrinsicContentSize: CGSize {
        let margin: CGFloat = 40
        let titleWidth = titleLabel?.intrinsicContentSize.width ?? 0
        return CGSize(width: titleWidth + margin, height: 30)
    }
    
    override public var isEnabled: Bool {
        didSet {
            setAlpha()
        }
    }
    
    private func setAlpha() {
        alpha = isEnabled ? 1 : 0.3
    }
}

