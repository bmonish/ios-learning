//
//  MVVMTableAndTestTests.swift
//  MVVMTableAndTestTests
//
//  Created by monish-pt4649 on 03/02/22.
//

import XCTest
@testable import MVVMTableAndTest

class MVVMTableAndTestTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCourseViewModel() {
        let course = Course(id: 0, name: "My Course Name", number_of_lessons: 10)
        let courseViewModel = CourseViewModel(course: course)
        
        // what is it that we want to test?
        XCTAssertEqual(course.name, courseViewModel.name)
        XCTAssertEqual("Lessons: \(course.number_of_lessons)", courseViewModel.detailTextString)
        XCTAssertEqual(.none, courseViewModel.accessoryType)
    }
    
    func testCourseViewModelLessonsOverThreshold() {
        let course = Course(id: 0, name: "My Course Name", number_of_lessons: 100)
        let courseViewModel = CourseViewModel(course: course)
        
        XCTAssertEqual("Lessons 30+ Check it Out!", courseViewModel.detailTextString)
        XCTAssertEqual(.detailDisclosureButton, courseViewModel.accessoryType)
    }

}
