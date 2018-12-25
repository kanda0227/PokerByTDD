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
        titleLabel?.textColor = colorSet.backgroundColor()
        layer.cornerRadius = 5
    }
    
    public override var intrinsicContentSize: CGSize {
        let margin: CGFloat = 60
        let titleWidth = titleLabel?.intrinsicContentSize.width ?? 0
        return CGSize(width: titleWidth + margin, height: 30)
    }
}
