//
//  UICollectionViewExtension.swift
//  Utility
//
//  Created by Kanda Sena on 2018/12/09.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public func register<T: UICollectionViewCell>(_ type: T.Type) {
        let nibName = String(describing: type)
        register(UINib(nibName: nibName, bundle: Bundle(for: type)), forCellWithReuseIdentifier: nibName)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
