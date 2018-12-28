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
    case walk
    /// 寝る
    case sleep
    
    private func animateImage() -> [Neko.Pose] {
        switch self {
        case .sit:
            return [.sit1]
        case .meow:
            return [.sit1, .sit2]
        case .frolic:
            return [.stand, .fight]
        case .walk:
            return [.walk_r1, .walk_r2]
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
        case .walk:
            return 0.8
        default:
            return 1
        }
    }
    
    public func repeatCount() -> Int {
        switch self {
        case .meow:
            return 1
        case .frolic:
            return 0
        case .walk:
            return 0
        default:
            return 0
        }
    }
}
