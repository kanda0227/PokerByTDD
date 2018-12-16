//
//  ColorSet.swift
//  Model
//
//  Created by Kanda Sena on 2018/12/15.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation

private let selectedColorSet = "selectedColorSet"

public enum ColorSet: String, CaseIterable {
    case `default` = "デフォルト"
    case cute = "キュート"
    case cool = "クール"
    case passion = "パッション"
    
    public func navigationBarColor() -> UIColor {
        switch self {
        case .default:
            return UIColor(named: "pink")!
        case .cute:
            return UIColor(named: "red")!
        case .cool:
            return UIColor(named: "purple")!
        case .passion:
            return UIColor(named: "orange")!
        }
    }
    
    public func backgroundColor() -> UIColor {
        switch self {
        case .default:
            return UIColor(named: "beige")!
        case .cute:
            return UIColor(named: "whitepink")!
        case .cool:
            return UIColor(named: "softblue")!
        case .passion:
            return UIColor(named: "yellow")!
        }
    }
    
    public func tabBarColor() -> UIColor {
        switch self {
        case .default:
            return UIColor(named: "green")!
        case .cute:
            return UIColor(named: "brown")!
        case .cool:
            return UIColor(named: "trinityblue")!
        case .passion:
            return UIColor(named: "positiveblue")!
        }
    }
    
    public func tabBarItemColor() -> UIColor {
        switch self {
        case .default:
            return UIColor(named: "blue")!
        case .cute:
            return UIColor(named: "gold")!
        case .cool:
            return UIColor(named: "lightgreen")!
        case .passion:
            return UIColor(named: "orangered")!
        }
    }
    
    public func textColor() -> UIColor {
        switch self {
        case .default:
            return UIColor(named: "black")!
        case .cute:
            return UIColor(named: "navy")!
        case .cool:
            return UIColor(named: "trinityBlack")!
        case .passion:
            return UIColor(named: "positivegreen")!
        }
    }
    
    public func save() {
        UserDefaults.standard.set(self.rawValue, forKey: selectedColorSet)
        ColorSetNotification.shared.post(self)
    }
    
    public static func restore() -> ColorSet {
        let rawValue = UserDefaults.standard.string(forKey: selectedColorSet)
        return rawValue.flatMap(ColorSet.init) ?? .default
    }
}
