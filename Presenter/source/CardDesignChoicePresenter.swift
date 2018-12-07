//
//  CardDesignChoicePresenter.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/04.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import Utility
import UIKit

public final class CardDesignChoicePresenter {
    
    public init() {}
    
    public func restoreImage(category: CardDesignCategory) -> UIImage? {
        return CardImageHelper.shared.image(category)
    }
    
    public func saveImage(_ image: UIImage, category: CardDesignCategory) {
        CardImageHelper.shared.saveImage(image, category: category)
    }
}
