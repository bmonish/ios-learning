//
//  MySegmentedControlTests.swift
//  MyResubaleComponentsTests
//
//  Created by monish-pt4649 on 11/02/22.
//

import XCTest
@testable import MyResubaleComponents

class MySegmentedControlTests: XCTestCase {
    
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
