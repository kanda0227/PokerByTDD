//
//  NekoWalkCalculation.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/27.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

public final class NekoWalkCalculation {
    
    private let walkSpeed: CGFloat = 10
    private let interval: TimeInterval = 0.1
    
    private var startPoint = CGPoint(x: 0, y: 0)
    private var goalPoint = CGPoint(x: 0, y: 0)
    private var position = CGPoint(x: 0, y: 0)
    
    private var timer: Timer?
    
    static public let shared = NekoWalkCalculation()
    
    private let positionSubject = PublishSubject<CGPoint>()
    private let stopSubject = PublishSubject<Void>()
    
    public func walk(startPoint: CGPoint, goalPoint: CGPoint) {
        self.startPoint = startPoint
        self.goalPoint = goalPoint
        self.position = startPoint
        
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.postWalk), userInfo: nil, repeats: true)
    }
    
    public func stop() {
        timer?.invalidate()
        stopSubject.onNext(())
    }
    
    public func walkObservable() -> Observable<CGPoint> {
        return positionSubject.asObservable()
    }
    
    public func stopObservable() -> Observable<Void> {
        return stopSubject.asObservable()
    }
    
    private func direction() -> (x: CGFloat, y: CGFloat) {
        let dx = goalPoint.x - startPoint.x
        let dy = goalPoint.y - startPoint.y
        return (dx / sqrt(pow(dx, 2) + pow(dy, 2)), dy / sqrt(pow(dx, 2) + pow(dy, 2)))
    }
    
    @objc private func postWalk() {
        let next = position
        let dir = direction()
        position.x += (dir.x * CGFloat(interval) * walkSpeed)
        position.y += (dir.y * CGFloat(interval) * walkSpeed)
        positionSubject.onNext(next)
        
        if distance(next, goalPoint) < (walkSpeed * CGFloat(interval)) {
            stop()
        }
    }
    
    private func distance(_ lhs: CGPoint, _ rhs: CGPoint) -> CGFloat {
        return sqrt(pow((lhs.x - rhs.x), 2) + pow((lhs.y - rhs.y), 2))
    }
}
