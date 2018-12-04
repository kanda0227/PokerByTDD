//
//  CardDesignChoicePresenter.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/04.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import RealmSwift
import Utility
import UIKit

final class CardDesignChoicePresenter {
    
    private let realm = try! Realm()
    
    init() {}
    
    func restoreImage(category: CardDesignCategory) -> UIImage? {
        return realm.restoreImage(key: category.key())
    }
    
    func saveImage(_ image: UIImage, category: CardDesignCategory) {
        realm.saveImage(image, key: category.key())
    }
}
