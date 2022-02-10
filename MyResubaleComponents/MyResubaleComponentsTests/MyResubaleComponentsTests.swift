//
//  MyResubaleComponentsTests.swift
//  MyResubaleComponentsTests
//
//  Created by monish-pt4649 on 04/02/22.
//

import XCTest
@testable import MyResubaleComponents

class MyResubaleComponentsTests: XCTestCase {
    
    // Tests for buttons
    
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
    
    // Tests for UISegmented Control
    @objc
    func hello() {
        print("hello")
    }
    
    func testSegmentControl() {
        let items = ["Hi!", "Bye"]
        
        let segmentControl = UISegmentedControl.configureMySegmentedControl(items: items, action: #selector(hello), forTarget: nil)
        
        XCTAssertEqual(segmentControl.numberOfSegments, items.count)
        XCTAssertEqual(segmentControl.selectedSegmentIndex, -1)
    }
    
    func testCustomSegmentControl() {
        let items = ["1", "2", "3"]
        let expectedBorderColor = MyColors.blue.getMyColor().cgColor
        let expectedTintColor = MyColors.red.getMyColor()
        
        let segmentControl = UISegmentedControl.configureMySegmentedControl(items: items, action: #selector(hello), forTarget: nil, borderColor: .blue, tintColor: .red)
        
        XCTAssertEqual(segmentControl.numberOfSegments, items.count)
        XCTAssertEqual(segmentControl.layer.borderColor, expectedBorderColor)
        XCTAssertEqual(segmentControl.selectedSegmentTintColor, expectedTintColor)
    }

}
