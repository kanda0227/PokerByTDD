//
//  NekoFace.swift
//  Model
//
//  Created by Kanda Sena on 2019/01/16.
//  Copyright © 2019 sena.kanda. All rights reserved.
//

import Foundation

public enum NekoFace {
    /// 笑顔
    case smile
    /// 泣き顔
    case tearful
    /// ポーカーフェイス
    case pokerFace
    
    public func face() -> String {
        switch self {
        case .smile:
            return "(`･ω･´)"
        case .tearful:
            return "(´･ω･`)"
        case .pokerFace:
            return "( ˙-˙ )"
        }
    }
}
