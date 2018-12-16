//
//  Neko.swift
//  Model
//
//  Created by Kanda Sena on 2018/12/16.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

private let selectedNekoKey = "selectedNekoKey"

public enum Neko: String, CaseIterable {
    /// みけねこ
    case mike
    /// くろねこ
    case kuro
    /// しろねこ
    case shiro
    /// ロシアンブルー
    case russian
    /// くつした
    case kutsusita
    /// 未所持用
    case unknown
    
    static public var allNekos: [Neko] {
        return Neko.allCases.filter { $0 != .unknown }
    }
    
    static public var libraryNekos: [Neko] {
        return allNekos.map { $0.hasNeko ? $0 : .unknown }
    }
    
    private var hasKey: String {
        return "hasNekoKey"
    }
    
    fileprivate func hasNekoKey() -> String {
        return hasKey + rawValue
    }
    
    private var hasNeko: Bool {
        return restore()
    }
    
    public var name: String {
        switch self {
        case .mike:
            return "みけねこさん"
        case .kuro:
            return "くろねこさん"
        case .shiro:
            return "しろねこさん"
        case .russian:
            return "ロシアンブルーさん"
        case .kutsusita:
            return "くつしたさん"
        case .unknown:
            return "？？？"
        }
    }
    
    func save() {
        UserDefaults.standard.set(true, forKey: hasNekoKey())
    }
    
    func restore() -> Bool {
        return UserDefaults.standard.object(forKey: hasNekoKey()) as? Bool ?? false
    }
    
    public func select() {
        UserDefaults.standard.setValue(self.rawValue, forKey: selectedNekoKey)
    }
    
    static public func selectedNeko() -> Neko? {
        let nekoValue = UserDefaults.standard.string(forKey: selectedNekoKey)
        return nekoValue.flatMap(Neko.init)
    }
}

public extension Neko {
    public enum Pose: String {
        /// 座る (真顔)
        case sit1
        /// 座る (笑顔)
        case sit2
    }
    
    public func image(pose: Neko.Pose = .sit1) -> UIImage {
        guard self != .unknown else { return #imageLiteral(resourceName: "neko") }
        let imageName = "\(rawValue)_neko_\(pose.rawValue)"
        // リソースはちゃんと用意してね
        return UIImage(named: imageName)!
    }
}
