//
//  UIImageExtension.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/04.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func resize(_ targetSize: CGSize) -> UIImage? {
        let scale = min(targetSize.width/size.width,
                        targetSize.height/size.height)
        let resizedSize = CGSize(width: size.width * scale, height: size.height * scale)
        UIGraphicsBeginImageContext(resizedSize)
        draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
