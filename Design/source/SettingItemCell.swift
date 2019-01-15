//
//  SettingItemCell.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Utility
import Model

public final class SettingItemCell: UITableViewCell, ColorSetViewProtocol {
    
    @IBOutlet private weak var itemLabel: CustomLabel!
    
    public func set(itemName: String) {
        itemLabel.text = itemName
        setupColor()
    }
    
    public func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
        itemLabel.reloadColor(colorSet: colorSet)
    }
}
