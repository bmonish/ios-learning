//
//  ZCRemoteWorkStatusModel.swift
//  DemoTableRemoteWork
//
//  Created by monish-pt4649 on 08/03/22.
//

import UIKit

enum EphemeralOptions: Int {
    case fifteen = 15
    case thirty = 30
    case fortyFive = 45
    case sixty = 60
}

struct StatusDataModel {
    var title: String
    var iconCharacter: String
    var iconColor: UIColor
    var hasOptions: Bool
    var options: [EphemeralOptions]
    var selectedOption: EphemeralOptions
    var isCollapsed: Bool
    
    
    init(title: String, iconCharacter: String, iconColor: UIColor, hasOptions: Bool = false, options: [EphemeralOptions] = [], selectedOption: EphemeralOptions = .fifteen, isCollapsed: Bool = true) {
        self.title = title
        self.iconCharacter = iconCharacter
        self.iconColor = iconColor
        self.hasOptions = hasOptions
        self.options = options
        self.selectedOption = selectedOption
        self.isCollapsed = isCollapsed
    }
}
