//
//  ViewController.swift
//  LottieAnimation
//
//  Created by monish-pt4649 on 28/02/22.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupAnimation()
    }

    private func setupAnimation() {
        animationView.animation = Animation.named("lottie-animation")
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView.center = view.center
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        view.addSubview(animationView)
    }
}

