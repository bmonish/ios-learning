//
//  UnitTestSampleTests.swift
//  UnitTestSampleTests
//
//  Created by monish-pt4649 on 01/02/22.
//

import XCTest
@testable import UnitTestSample

class UnitTestSampleTests: XCTestCase {

    func testAddStuff() {
        
        let math = MathStuff()
        
        let result = math.addNumbers(x: 1, y: 2)
        XCTAssertEqual(result, 3)
    }
    
    func testSubStuff() {
        
        let math = MathStuff()
        
        let result = math.subNumbers(x: 1, y: 2)
        XCTAssertEqual(result, -1)
    }
    
    func testMulStuff() {
        
        let math = MathStuff()
        
        let result = math.mulNumbers(x: 1, y: 2)
        XCTAssertEqual(result, 2)
    }

}
