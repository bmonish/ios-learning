//
//  Support+Extension.swift
//  DemoTableRemoteWork
//
//  Created by monish-pt4649 on 03/03/22.
//

import UIKit

//MARK: - Support for Icon Characters

extension UIFont {
    static func fontIcon(_ size: CGFloat) -> UIFont {
        return UIFont(name: "ios-icon", size: size)!
    }
}

extension String {
    func iconCharacter() -> String {
        switch self {
        case "cupFill":
            return "\u{ea69}"
        case "laptopFill":
            return "\u{ea6a}"
        case "lunchFill":
            return "\u{ea6b}"
        case "targetFill":
            return "\u{ea6c}"
        case "doNotDisturb":
            return "\u{ea5a}"
        default:
            return ""
        }
    }
}
