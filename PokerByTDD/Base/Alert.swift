//
//  Alert.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2019/01/02.
//  Copyright © 2019 sena.kanda. All rights reserved.
//

import UIKit

public extension UIAlertController {
    
    static func alert(title: String) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: title, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertController
    }
}
