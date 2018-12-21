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
    /// 歩く
    case walk
    /// 寝る
    case sleep
    
    private func animateImage() -> [Neko.Pose] {
        switch self {
        case .meow:
            return [.sit1, .sit2]
        default:
            return [.sit1]
        }
    }
    
    public func animateImage(neko: Neko) -> [UIImage] {
        return animateImage().map { neko.image(pose: $0) }
    }
}
