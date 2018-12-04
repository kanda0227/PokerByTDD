//
//  RealmExtension.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import RealmSwift
import UIKit

class ImageObject: Object {
    @objc dynamic var data: Data = Data()
    @objc dynamic var key: String = ""
    
    /// 絶対呼んでね！
    fileprivate func set(data: Data, key: String) {
        self.data = data
        self.key = key
    }
}

extension Realm {
    
    public func saveImage(_ image: UIImage, key: String) {
        if let data = image.pngData() {
            if let imageObj = objects(ImageObject.self).filter("key = '\(key)'").first {
                try! write {
                    imageObj.data = data
                }
            } else {
                let imageObj = ImageObject()
                imageObj.set(data: data, key: key)
                try! write {
                    add(imageObj)
                }
            }
        }
    }
    
    public func restoreImage(key: String) -> UIImage? {
        guard let imageObj = objects(ImageObject.self).filter("key = '\(key)'").first else { return nil }
        return UIImage(data: imageObj.data)
    }
}
