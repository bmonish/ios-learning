//
//  MyColors.swift
//  MyResubaleComponents
//
//  Created by monish-pt4649 on 04/02/22.
//

import Foundation
import UIKit

public enum MyColors {
    case red
    case blue
    case green
    case white
    case black
    
    public func getMyColor() -> UIColor {
        switch self {
        case .red:
            return UIColor.red
        case .blue:
            return UIColor.blue
        case .green:
            return UIColor.green
        case .white:
            return UIColor.white
        case .black:
            return UIColor.black
        }
    }
}
