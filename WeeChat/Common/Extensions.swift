//
//  Extensions.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-07-31.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static var secondaryBackground: UIColor {
        get {
            return UIColor.fromRGB(239, 239, 239)
        }
    }
    
    static var primaryApp: UIColor {
        get {
            return UIColor.black
        }
    }
    
    static var primaryText: UIColor {
        get {
            return UIColor.black
        }
    }
    
    static var placeholderText: UIColor {
        get {
            return UIColor.fromRGB(117, 117, 117)
        }
    }
    
    static var primaryGreen: UIColor {
        get {
            return UIColor.fromRGB(70, 206, 86)
        }
    }
    
    static var secondaryGrey: UIColor {
        get {
            return UIColor.fromRGB(221, 221, 221)
        }
    }
    
    static func fromRGB( _ r : Int, _ g : Int, _ b : Int , _ alpha : CGFloat = 1.0) -> UIColor {
        return UIColor.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: alpha)
    }
}

extension UIFont {
    
    static var title: UIFont {
        get {
            return UIFont.systemFont(ofSize: 15, weight: .regular)
        }
    }
    
    static var subTitle: UIFont {
        get {
            return UIFont.systemFont(ofSize: 13, weight: .regular)
        }
    }
}

extension Encodable {
    
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    
    var data: Data {
        return try! JSONEncoder().encode(self)
    }
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:]
    }
}
