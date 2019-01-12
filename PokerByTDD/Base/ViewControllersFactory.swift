//
//  ViewControllersFactory.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2019/01/12.
//  Copyright © 2019 sena.kanda. All rights reserved.
//

import UIKit
import Model

final class ViewControllersFactory {
    
    static let shared = ViewControllersFactory()
    
    private init() {}
    
    func vc(_ identifier: VCIdentifier) -> UIViewController {
        return identifier.vc
    }
    
    func vc(_ screen: Screen) -> UIViewController? {
        return screen.presentIdentifier().map(vc)
    }
}

enum VCIdentifier {
    case nekoLibrary
    
    private var storyboardName: String {
        switch self {
        case .nekoLibrary:
            return "NekoLibraryView"
        }
    }
    
    fileprivate var vc: UIViewController {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
    }
}

private extension Screen {
    
    func presentIdentifier() -> VCIdentifier? {
        switch presentVC {
        case .some(let vc) where vc == .nekoLibrary:
            return .nekoLibrary
        default:
            return nil
        }
    }
}
