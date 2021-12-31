//
//  ViewController.swift
//  TabBarController
//
//  Created by monish-pt4649 on 30/12/21.
//

import UIKit

class ViewController: UIViewController {

    var tabBarVc: UITabBarController!
    
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBlue
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    func setupTabBar() {
        tabBarVc = UITabBarController()
        
        let vc1 = UINavigationController(rootViewController: FirstViewController())
        let vc2 = UINavigationController(rootViewController: SecondViewController())
        let vc3 = UINavigationController(rootViewController: ThirdViewController())
        let vc4 = UINavigationController(rootViewController: FourthViewController())
        let vc5 = UINavigationController(rootViewController: FifthViewController())
        
        vc1.title = "Home"
        vc2.title = "Contact"
        vc3.title = "About"
        vc4.title = "Help"
        vc5.title = "Settings"
            
        tabBarVc.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
        
        guard let items = tabBarVc.tabBar.items else { return }
        let images = ["house", "phone", "info.circle", "questionmark.circle", "gear"]
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }

        tabBarVc.modalPresentationStyle = .fullScreen
    }
    
    @objc
    func didTapButton() {
        setupTabBar()
        present(tabBarVc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.center = view.center
    }
}

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // Setting only the Navigation title
        navigationItem.title = "Welcome"
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Both Navigation and Tab Bar Title
        title = "Contact"
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "About"
    }
}

class FourthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "Help"
    }
}

class FifthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        title = "Settings"
    }
}

