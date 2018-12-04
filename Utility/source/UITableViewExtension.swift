//
//  UITableViewExtension.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func register<T: UITableViewCell>(_ type: T.Type) {
        let nibName = String(describing: type)
        register(UINib(nibName: nibName, bundle: Bundle(for: type)), forCellReuseIdentifier: nibName)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}
