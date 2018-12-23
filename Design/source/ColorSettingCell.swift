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
    
    private func setupColor() {
        guard let colorSet = colorSet else { return }
        navigationBarColorView.backgroundColor = colorSet.navigationBarColor()
        backgroundColorView.backgroundColor = colorSet.backgroundColor()
        tabBarColorView.backgroundColor = colorSet.tabBarColor()
        tabBarItemColorView.backgroundColor = colorSet.tabBarItemColor()
        textSampleLabel.textColor = colorSet.textColor()
        textSampleLabel.text = colorSet.rawValue
        self.layer.borderWidth = isSelected ? 2 : 0
        contentView.layer.borderColor = colorSet.navigationBarColor().cgColor
    }
    
    override public var isSelected: Bool {
        didSet {
            setupColor()
        }
    }
}
