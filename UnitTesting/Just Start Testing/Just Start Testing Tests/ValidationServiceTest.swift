//
//  ValidationServiceTest.swift
//  Just Start Testing Tests
//
//  Created by monish-pt4649 on 01/02/22.
//  Copyright © 2022 Kilo Loco. All rights reserved.
//

import XCTest
@testable import Just_Start_Testing

class ValidationServiceTest: XCTestCase {

    var validation: ValidationService!
    
    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }
    
    override func tearDown() {
        validation = nil
        super.tearDown()
    }
    
    func test_isValidUsername() throws {
        XCTAssertNoThrow(try validation.validateUsername("monish baskar"))
    }
    
    func test_isValidPassword() throws {
        XCTAssertNoThrow(try validation.validatePassword("monish baskar"))
    }
    
    func test_usernameIsNil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername(nil)) { thrownError in
            error = thrownError as? ValidationError
         }
        
        XCTAssertEqual(error?.errorDescription, expectedError.errorDescription)
    }
    
    func test_passwordIsNil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword(nil)) { thrownError in
            error = thrownError as? ValidationError
         }
        
        XCTAssertEqual(error?.errorDescription, expectedError.errorDescription)
    }
    
    func test_usernameTooShort() throws {
        let expectedError = ValidationError.usernameTooShort
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername("mo")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(error?.errorDescription, expectedError.errorDescription)
    }
    
    func test_usernameTooLong() throws {
        let expectedError = ValidationError.usernameTooLong
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername("mosdjfgsdhjfgsdhjgfshdjgfhjsdgfjshdsdj")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(error?.errorDescription, expectedError.errorDescription)
    }
    
    func test_passwordTooShort() throws {
        let expectedError = ValidationError.passwordTooShort
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword("monish")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(error?.errorDescription, expectedError.errorDescription)
    }
    
    func test_passwordTooLong() throws {
        let expectedError = ValidationError.passwordTooLong
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword("monishmonishmonishmonishmonishmonish")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(error?.errorDescription, expectedError.errorDescription)
    }
}
