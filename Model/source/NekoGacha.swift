//
//  NekoGacha.swift
//  Model
//
//  Created by Kanda Sena on 2018/12/08.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import RxSwift

public final class NekoGacha {
    
    private let wallet = Wallet.shared
    private let gachaPrice = 200
    private lazy var canGachaSubject = BehaviorSubject<Bool>(value: canGacha)
    private let bag = DisposeBag()
    
    private init() {
        wallet.observable()
            .subscribe(onNext: { [weak self] _ in
                guard let _self = self else { return }
                _self.canGachaSubject.onNext(_self.canGacha) })
            .disposed(by: bag)
    }
    
    public static let shared = NekoGacha()
    
    public func get() -> (neko: Neko, new: Bool)? {
        guard canGacha else { return nil }
        wallet.pay(gachaPrice)
        let neko = Neko.allNekos.randomElement()!
        let new = !neko.restore()
        neko.save()
        return (neko, new)
    }
    
    private var canGacha: Bool {
        return wallet.value() >= gachaPrice
    }
    
    public func canGachaObservable() -> Observable<Bool> {
        return canGachaSubject.asObservable()
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
        case .black:
            return "くろねこさん"
        case .white:
            return "しろねこさん"
        case .russianBlue:
            return "ロシアンブルーさん"
        case .socks:
            return "くつしたさん"
        case .unknown:
            return "？？？"
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
        case .unknown:
            return #imageLiteral(resourceName: "neko")
        }
    }
    
    fileprivate func save() {
        UserDefaults.standard.set(true, forKey: hasNekoKey())
    }
    
    fileprivate func restore() -> Bool {
        return UserDefaults.standard.object(forKey: hasNekoKey()) as? Bool ?? false
    }
}
