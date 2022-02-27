//
//  RemoteWorkCellV3.swift
//  DemoTableRemoteWork
//
//  Created by monish-pt4649 on 04/03/22.
//

import UIKit

protocol DropDownActionDelegate: AnyObject {
    func dropDownAction(indexPath: IndexPath)
}

protocol OptionTapDelegate: AnyObject {
    func optionTapped(duration: Int)
}

class RemoteWorkCell: UITableViewCell, OptionTapDelegate {
    
    func optionTapped(duration: Int) {
        print("Option Tapped: \(duration)")
    }
    
    let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.backgroundColor = UIColor(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1)
        mainStackView.layer.cornerRadius = 5
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.clipsToBounds = true
        return mainStackView
    }()
    
    let statusStackView: UIStackView = {
        let statusStackView = UIStackView()
        statusStackView.axis = .horizontal
        statusStackView.spacing = 20
        statusStackView.alignment = .center
        statusStackView.isLayoutMarginsRelativeArrangement = true
        statusStackView.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        statusStackView.translatesAutoresizingMaskIntoConstraints = false
        return statusStackView
    }()
    
    var optionWrapperView: OptionsView = OptionsView()
    
    weak var dropDownDelegate: DropDownActionDelegate?
    var indexPath: IndexPath!
    
    var hasOptions: Bool = false
    var filteredOptions: [EphemeralOptions] = [.thirty, .fortyFive, .sixty]
    
    let statusIcon: UILabel = {
        let statusIcon = UILabel()
        statusIcon.font = UIFont.fontIcon(24)
        statusIcon.backgroundColor = .white
        statusIcon.clipsToBounds = true
        statusIcon.layer.cornerRadius = 40 / 2
        statusIcon.textAlignment = .center
        statusIcon.translatesAutoresizingMaskIntoConstraints = false
        return statusIcon
    }()
    
    let circlePath = UIBezierPath(arcCenter: CGPoint (x: 40 / 2, y: 40 / 2),
                                  radius: 40 / 2,
                                  startAngle: CGFloat(-0.5 * .pi),
                                  endAngle: CGFloat(1.5 * .pi),
                                  clockwise: true)
    
    let circleShape: CAShapeLayer = {
        let circleShape = CAShapeLayer()
        circleShape.fillColor = UIColor.clear.cgColor
        circleShape.lineWidth = 4
        circleShape.strokeStart = 0.0
        circleShape.strokeEnd = 0.5
        return circleShape
    }()
    
    let statusText: UILabel = {
        let statusText = UILabel()
        statusText.font = UIFont.systemFont(ofSize: 20)
        statusText.textColor = .black
        return statusText
    }()
    
    let dropDownButton: UIButton = {
        let dropDownButton = UIButton()
        dropDownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        return dropDownButton
    }()
    
    func configure(statusIcon: String,
                   statusIconColor: UIColor,
                   statusText: String,
                   hasOptions: Bool = false,
                   options: [EphemeralOptions] = [],
                   selectedOption: EphemeralOptions = .fifteen,
                   tag: Int = 0) {
        
        self.statusIcon.text = statusIcon
        self.statusIcon.textColor  = statusIconColor
        self.statusIcon.layer.borderColor  = statusIconColor.cgColor
        self.statusText.text = statusText
        self.hasOptions = hasOptions
        self.circleShape.strokeColor = statusIconColor.cgColor
        
        if hasOptions {
            dropDownButton.addTarget(self, action: #selector(dropDownAction), for: .touchUpInside)
            dropDownButton.tag = tag
            
            self.statusText.text = "\(statusText) for \(selectedOption.rawValue) mins"
            
            filteredOptions = options.filter { option in
                return option != selectedOption
            }
            
            optionWrapperView.setupButtons(filteredOptions: filteredOptions)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        filteredOptions = []
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        optionWrapperView.optionTappedDelegate = self
        
        contentView.addSubview(mainStackView)
        circleShape.path = circlePath.cgPath
        statusIcon.layer.addSublayer(circleShape)
        
        statusStackView.addArrangedSubview(statusIcon)
        statusStackView.addArrangedSubview(statusText)
        
        mainStackView.addArrangedSubview(statusStackView)
        
        statusStackView.addArrangedSubview(dropDownButton)
        dropDownButton.isHidden = true
        
        mainStackView.addArrangedSubview(optionWrapperView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            statusIcon.widthAnchor.constraint(equalToConstant: 40),
            statusIcon.heightAnchor.constraint(equalToConstant: 40),
            
            optionWrapperView.heightAnchor.constraint(equalToConstant: 40),
            
            dropDownButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if (hasOptions == true) {
            dropDownButton.isHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(isCollapsed: Bool = true) {
        self.optionWrapperView.isHidden = isCollapsed
        
        if (isCollapsed) {
            self.dropDownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        } else {
            self.dropDownButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
    }
    
    @objc func dropDownAction() {
        guard let index = indexPath else { return }
        
        dropDownDelegate?.dropDownAction(indexPath: index)
    }
}
