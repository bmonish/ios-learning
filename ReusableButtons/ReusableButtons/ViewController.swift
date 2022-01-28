//
//  ViewController.swift
//  ReusableButtons
//
//  Created by monish-pt4649 on 28/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let twoLinedButton = TwoLinedButton(frame: CGRect(x: 0, y: 0, width: 300, height: 55))
        view.addSubview(twoLinedButton)
        twoLinedButton.center = view.center
        twoLinedButton.configure(with: TwoLinedButtonViewModel(primaryText: "Start Trial", secondaryText: "30 days free then $2.99 / year"))
        
        let iconButton = IconTextButton(frame: CGRect(x: (view.frame.size.width - 300) / 2, y: 60, width: 300, height: 55))
        view.addSubview(iconButton)
        iconButton.configure(with: IconTextButtonViewModel(text: "Check out", image: UIImage(systemName: "cart"), backgroundColor: .systemRed))
    }
    
}

