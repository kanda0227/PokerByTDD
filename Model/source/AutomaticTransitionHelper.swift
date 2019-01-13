//
//  AutomaticTransitionHelper.swift
//  Model
//
//  Created by Kanda Sena on 2019/01/12.
//  Copyright © 2019 sena.kanda. All rights reserved.
//

import Foundation
import RxSwift

public final class AutomaticTransitionHelper {
    
    static public let shared = AutomaticTransitionHelper()
    
    private let subject = PublishSubject<Screen>()
    
    private init() {}
    
    public func post(_ tab: Screen) {
        subject.onNext(tab)
    }
    
    public func observable() -> Observable<Screen> {
        return subject.asObservable()
    }
}

public enum TopTab: Int {
    case poker = 0
    case nekoGacha
    case nekoRoom
    case shop
    case setting
    
    public var title: String {
        switch self {
        case .poker:
            return "ポーカー"
        case .nekoGacha:
            return "ねこガチャ"
        case .nekoRoom:
            return "ねこ部屋"
        case .shop:
            return "ショップ"
        case .setting:
            return "設定"
        }
    }
}

public enum Screen {
    case poker
    case nekoGacha
    case nekoRoom
    case shop
    case setting
    case nekoLibrary
    
    public var tab: TopTab {
        switch self {
        case .poker:
            return .poker
        case .nekoGacha, .nekoLibrary:
            return .nekoGacha
        case .nekoRoom:
            return .nekoRoom
        case .shop:
            return .shop
        case .setting:
            return .setting
        }
    }
    
    public var pushVC: Screen? {
        switch self {
        case .nekoLibrary:
            return self
        default:
            return nil
        }
    }
}
