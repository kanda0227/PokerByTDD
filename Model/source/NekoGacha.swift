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
        save(neko: neko)
        return neko
    }
    
    private func save(neko: Neko) {
        UserDefaults.standard.set(true, forKey: neko.hasNekoKey())
    }
    
    private func restore(neko: Neko) -> Bool {
        return UserDefaults.standard.object(forKey: neko.hasNekoKey()) as? Bool ?? false
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
}
