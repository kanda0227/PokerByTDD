//
//  CardImageHelper.swift
//  Presenter
//
//  Created by Kanda Sena on 2018/12/07.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit
import Model

public final class CardImageHelper {
    
    public static let shared = CardImageHelper()
    
    private let realm = try! Realm()
    
    private init () {}
    
    public func backImage() -> UIImage? {
        return realm.restoreImage(key: CardDesignCategory.back.key())
    }
    
    public func cardImage(_ card: Card?) -> UIImage? {
        // 該当のカテゴリキーの画像を一旦全部復元させているので
        // パフォーマンスが悪い気がするが，現状では高々2つなのでこのままにしておく
        return card?.category.compactMap { realm.restoreImage(key: $0.key()) }.first
    }
}
