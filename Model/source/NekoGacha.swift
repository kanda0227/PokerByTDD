//
//  NekoGacha.swift
//  Model
//
//  Created by Kanda Sena on 2018/12/08.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

public final class NekoGacha {
    
    private init() {}
    
    public static let shared = NekoGacha()
    
    public func get() -> Neko {
        let neko = Neko.allCases.randomElement()!
        neko.save()
        return neko
    }
}

public enum Neko: String, CaseIterable {
    /// みけねこ
    case mike
    /// くろねこ
    case black
    /// しろねこ
    case white
    /// ロシアンブルー
    case russianBlue
    /// くつした
    case socks
    
    private var hasKey: String {
        return "hasNekoKey"
    }
    
    fileprivate func hasNekoKey() -> String {
        return hasKey + rawValue
    }
    
    public var hasNeko: Bool {
        return restore()
    }
    
    public var name: String {
        switch self {
        case .mike:
            return "みけねこさん"
        case .black:
            return "くろねこさん"
        case .white:
            return "しろねこさん"
        case .russianBlue:
            return "ロシアンブルーさん"
        case .socks:
            return "くつしたさん"
        }
    }
    
    public var image: UIImage {
        switch self {
        case .mike:
            return #imageLiteral(resourceName: "mike_neko_sit1")
        case .black:
            return #imageLiteral(resourceName: "kuro_neko_sit1")
        case .white:
            return #imageLiteral(resourceName: "siro_neko_sit1")
        case .russianBlue:
            return #imageLiteral(resourceName: "rosian_neko_sit1")
        case .socks:
            return #imageLiteral(resourceName: "kutsusita_neko_sit1")
        }
    }
    
    fileprivate func save() {
        UserDefaults.standard.set(true, forKey: hasNekoKey())
    }
    
    fileprivate func restore() -> Bool {
        return UserDefaults.standard.object(forKey: hasNekoKey()) as? Bool ?? false
    }
}
