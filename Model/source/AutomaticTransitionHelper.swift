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
    
    private let subject = PublishSubject<TopTab>()
    
    private init() {}
    
    public func post(_ tab: TopTab) {
        subject.onNext(tab)
    }
    
    public func observable() -> Observable<TopTab> {
        return subject.asObservable()
    }
}

public enum TopTab: Int {
    case poker = 0
    case nekoGacha
    case nekoRoom
    case shop
    case setting
}
