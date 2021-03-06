//
//  NekoAction.swift
//  Model
//
//  Created by Kanda Sena on 2018/12/21.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

public enum NekoAction {
    /// 座る
    case sit
    /// 鳴く
    case meow
    /// じゃれる
    case frolic
    /// 歩く
    case walk(Direction)
    /// 寝る
    case sleep
    
    private func animateImage() -> [Neko.Pose] {
        switch self {
        case .sit:
            return [.sit1]
        case .meow:
            return [.sit2]
        case .frolic:
            return [.stand, .fight]
        case .walk(.right):
            return [.walk_r1, .walk_r2]
        case .walk(.left):
            return [.walk_l1, .walk_l2]
        default:
            return [.sit1]
        }
    }
    
    public func animateImage(neko: Neko) -> [UIImage] {
        return animateImage().map { neko.image(pose: $0) }
    }
    
    public func duration() -> TimeInterval {
        switch self {
        case .meow:
            return 1
        case .frolic:
            return 1
        case .walk(_):
            return 0.8
        default:
            return 1
        }
    }
    
    public func audio() -> NekoAudio? {
        switch self {
        case .meow:
            return .meow
        default:
            return nil
        }
    }
    
    public func repeatCount() -> Int {
        switch self {
        case .meow:
            return 1
        case .frolic:
            return 0
        case .walk(_):
            return 0
        default:
            return 0
        }
    }
    
    public enum Direction {
        case right
        case left
    }
}
