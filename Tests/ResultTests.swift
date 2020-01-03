//
//  ResultTests.swift
//  FirestoreClientTests
//
//  Created by Anas Alhasani on 1/3/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import XCTest
@testable import FirestoreClient

final class ResultTests: XCTestCase {
    
    func testMakeResultValueNotNil() {
        let expectedValue: Int? = 9
        let expectedError: Error? = nil
        let result = makeResult(expectedValue, expectedError)
        
        do {
            let value = try result.get()
            XCTAssertEqual(expectedValue, value)
        } catch {
            XCTFail()
        }
    }
    
    func testMakeResultErrorNotNil() {
        let expectedValue: Int? = nil
        let expectedError: TestError? = TestError()
        let result = makeResult(expectedValue, expectedError)
        
        do {
            _ = try result.get()
            XCTFail()
        } catch {
            XCTAssertEqual(expectedError, error as? TestError)
        }
    }
    
    func testMakeResultInvalidCombination() {
        let expectedError: CoreError = .invalidInputCombination
        
        do {
            let value: Int? = 10
            let error: Error? = TestError()
            let result = makeResult(value, error)
            _ = try result.get()
            XCTFail()
        } catch {
            XCTAssertEqual(expectedError, error as? CoreError)
        }
        
        do {
            let value: Int? = nil
            let error: Error? = nil
            let result = makeResult(value, error)
            _ = try result.get()
            XCTFail()
        } catch {
            XCTAssertEqual(expectedError, error as? CoreError)
        }
    }
}

private extension ResultTests {
    struct TestError: Error, Equatable {
        
    }
}

extension CoreError: Equatable {
    public static func == (lhs: CoreError, rhs: CoreError) -> Bool {
        String(describing: lhs) == String(describing: rhs)
    }
}
