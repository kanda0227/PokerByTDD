//
//  CustomButton.swift
//  Design
//
//  Created by Kanda Sena on 2018/12/25.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model

public final class CustomButton: UIButton {
    
    public var colorSet: ColorSet = .default {
        didSet {
            setColorSet()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        setColorSet()
    }
    
    private func setColorSet() {
        backgroundColor = colorSet.navigationBarColor()
        layer.cornerRadius = 5
        
        guard let text = titleLabel?.text else { return }
        let attributedText = NSAttributedString(string: text,
                                                        attributes: [.font : UIFont.boldSystemFont(ofSize: 15),
                                                                     .foregroundColor : colorSet.backgroundColor()])
        setAttributedTitle(attributedText, for: .normal)
    }
    
    public override var intrinsicContentSize: CGSize {
        let margin: CGFloat = 60
        let titleWidth = titleLabel?.intrinsicContentSize.width ?? 0
        return CGSize(width: titleWidth + margin, height: 30)
    }
}
