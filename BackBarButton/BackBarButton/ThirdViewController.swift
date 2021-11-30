//
//  ThirdViewController.swift
//  BackBarButton
//
//  Created by monish-pt4649 on 21/12/21.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var button = UIButton.configureMyBackBarButton(title: "Back with No Title", color: UIColor.blue)
    
    @objc
    func buttonClicked() {
        print("Button 2")
        navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    func setupView() {
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backButtonTitle = ""
        navigationItem.title = NSLocalizedString("Third", comment: "Third Screen in the App")
        // Do any additional setup after loading the view.
        setupView()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
