//
//  ColorSettingCell.swift
//  Design
//
//  Created by Kanda Sena on 2018/12/15.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model

public final class ColorSettingCell: UITableViewCell {
    
    @IBOutlet private weak var navigationBarColorView: UIView!
    @IBOutlet private weak var backgroundColorView: UIView!
    @IBOutlet private weak var tabBarColorView: UIView!
    @IBOutlet private weak var tabBarItemColorView: UIView!
    @IBOutlet private weak var textSampleLabel: UILabel!
    
    private var colorSet: ColorSet? {
        didSet {
            setupColor()
        }
    }
    
    public func set(_ colorSet: ColorSet) {
        self.colorSet = colorSet
    }
    
    public func selected(_ isSelectedColorSet: Bool) {
        self.isSelectedColorSet = isSelectedColorSet
    }
    
    private func setupColor() {
        guard let colorSet = colorSet else { return }
        navigationBarColorView.backgroundColor = colorSet.navigationBarColor()
        backgroundColorView.backgroundColor = colorSet.backgroundColor()
        tabBarColorView.backgroundColor = colorSet.tabBarColor()
        tabBarItemColorView.backgroundColor = colorSet.tabBarItemColor()
        textSampleLabel.textColor = colorSet.textColor()
        textSampleLabel.text = colorSet.rawValue
        self.layer.borderWidth = isSelectedColorSet ? 3 : 0
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    private var isSelectedColorSet: Bool = false {
        didSet {
            setupColor()
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            setupColor()
        }
    }
}
