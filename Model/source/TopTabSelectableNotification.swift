//
//  TopTabSelectableNotification.swift
//  Model
//
//  Created by Kanda Sena on 2018/12/23.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import RxSwift

public final class TopTabSelectableNotification {
    
    static public let shared = TopTabSelectableNotification()
    
    private let subject = BehaviorSubject<Bool>(value: true)
    
    private init () {}
    
    public func post(selectable: Bool) {
        subject.onNext(selectable)
    }
    
    public func shouldSelectable() -> Bool {
        return try! subject.value()
    }
}
