//
//  OptionsView.swift
//  DemoTableRemoteWork
//
//  Created by monish-pt4649 on 08/03/22.
//

import UIKit

class OptionsView: UIView {
    
    var optionButton1: UIButton!
    var optionButton2: UIButton!
    var optionButton3: UIButton!
    
    weak var optionTappedDelegate: OptionTapDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        optionButton1 = UIButton.configureOptionButton()
        optionButton2 = UIButton.configureOptionButton()
        optionButton3 = UIButton.configureOptionButton()
        
        addSubview(optionButton1)
        addSubview(optionButton2)
        addSubview(optionButton3)
        
        NSLayoutConstraint.activate([
            optionButton1.widthAnchor.constraint(equalToConstant: 80),
            optionButton1.heightAnchor.constraint(equalToConstant: 32),
            optionButton2.widthAnchor.constraint(equalToConstant: 80),
            optionButton2.heightAnchor.constraint(equalToConstant: 32),
            optionButton3.widthAnchor.constraint(equalToConstant: 80),
            optionButton3.heightAnchor.constraint(equalToConstant: 32),
            
            optionButton1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 76),
            optionButton1.topAnchor.constraint(equalTo: self.topAnchor),
            optionButton2.leadingAnchor.constraint(equalTo: optionButton1.trailingAnchor, constant: 10),
            optionButton2.topAnchor.constraint(equalTo: self.topAnchor),
            optionButton3.leadingAnchor.constraint(equalTo: optionButton2.trailingAnchor, constant: 10),
            optionButton3.topAnchor.constraint(equalTo: self.topAnchor),
        ])
    }
    
    func setupButtons(filteredOptions: [EphemeralOptions]) {
        optionButton1.setTitle("\(filteredOptions[0].rawValue) mins", for: .normal)
        optionButton1.tag = filteredOptions[0].rawValue
        optionButton2.setTitle("\(filteredOptions[1].rawValue) mins", for: .normal)
        optionButton2.tag = filteredOptions[1].rawValue
        optionButton3.setTitle("\(filteredOptions[2].rawValue) mins", for: .normal)
        optionButton3.tag = filteredOptions[2].rawValue
        
        optionButton1.addTarget(self, action: #selector(optionBtnTapped(_:)), for: .touchUpInside)
        optionButton2.addTarget(self, action: #selector(optionBtnTapped(_:)), for: .touchUpInside)
        optionButton3.addTarget(self, action: #selector(optionBtnTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    func optionBtnTapped(_ sender: UIButton) {
        optionTappedDelegate?.optionTapped(duration: sender.tag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
