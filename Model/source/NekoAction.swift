//
//  NekoAction.swift
//  Model
//
//  Created by Kanda Sena on 2018/12/21.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

public enum NekoAction {
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
        case .meow:
            return [.sit1, .sit2]
        case .frolic:
            return [.stand, .fight]
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
        default:
            return 0
        }
    }
}
