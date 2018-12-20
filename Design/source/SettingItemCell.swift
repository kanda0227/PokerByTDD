//
//  SettingItemCell.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

public final class SettingItemCell: UITableViewCell {
    
    @IBOutlet private weak var itemLabel: CustomLabel!
    
    public func set(itemName: String) {
        itemLabel.text = itemName
    }
}
