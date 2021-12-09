//
//  ViewController.swift
//  ToolBarForKeyboard
//
//  Created by monish-pt4649 on 21/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textField.addInputAccessoryView(title: "Done", target: self, selector: #selector(tapDone))
    }
    
    @objc func tapDone() {
        self.view.endEditing(true)
    }
}

