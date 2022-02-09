//
//  MyButtonsTests.swift
//  MyResubaleComponentsTests
//
//  Created by monish-pt4649 on 11/02/22.
//

import XCTest
@testable import MyResubaleComponents

class MyButtonsTests: XCTestCase {
    
    func testOutlineButton() {
        let expectedText = "Outline"
        let expectedTextColor = MyColors.green.getMyColor()
        let expectedBorderColor = MyColors.red.getMyColor()
        
        let button = UIButton.configureMyButton(title: "Outline", textColor: .green, borderColor: .red)
        
        XCTAssertEqual(button.titleLabel?.text, expectedText)
        XCTAssertEqual(button.titleLabel?.textColor, expectedTextColor)
        XCTAssertEqual(button.layer.borderColor, expectedBorderColor.cgColor)
    }
    
    func testFillButton() {
        let expectedText = "Fill"
        let expectedTextColor = MyColors.white.getMyColor()
        let expectedBackgroundColor = MyColors.blue.getMyColor()
        
        let button = UIButton.configureMyButton(title: "Fill", textColor: .white, bgColor: .blue)
        
        XCTAssertEqual(button.titleLabel?.text, expectedText)
        XCTAssertEqual(button.titleLabel?.textColor, expectedTextColor)
        XCTAssertEqual(button.backgroundColor, expectedBackgroundColor)
    }
    
    func testIconButton() {
        let expectedText = "Icon"
        let btnIcon: UIImage! = UIImage(systemName: "shareplay")?.withTintColor(.systemRed, renderingMode: .alwaysTemplate)
        let expectedTextColor = MyColors.white.getMyColor()
        let expectedBackgroundColor = MyColors.black.getMyColor()
        
        let button = UIButton.configureMyButton(title: "Icon", icon: btnIcon, textColor: .white, bgColor: .black)
        
        XCTAssertEqual(button.titleLabel?.text, expectedText)
        XCTAssertEqual(button.currentImage, btnIcon)
        XCTAssertEqual(button.titleLabel?.textColor, expectedTextColor)
        XCTAssertEqual(button.backgroundColor, expectedBackgroundColor)
    }

}
