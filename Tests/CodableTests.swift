//
//  CodableTests.swift
//  FirestoreClientTests
//
//  Created by Anas Alhasani on 1/3/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import XCTest
@testable import FirestoreClient

final class CodableTests: XCTestCase {
    func testEncodingAndDecoding() throws {
        let exptectedValue = TestEntity(
            string: "Hello, world!",
            int: 1,
            double: 10.0,
            bool: true
        )
        
        let expectedDictionary: JSONDictionary = [
            "string": "Hello, world!",
            "int": 1,
            "double": 10.0,
            "bool": true
        ]
        
        let data: Data = try exptectedValue.encoded()
        let decodableValue: TestEntity = try data.decoded()
        let dictionaryValue: JSONDictionary = try decodableValue.jsonDictionary()
        
        XCTAssertEqual(exptectedValue, decodableValue)
        XCTAssertEqual(expectedDictionary as NSDictionary, dictionaryValue as NSDictionary)
        XCTAssert(dictionaryValue["string"] is String)
        XCTAssert(dictionaryValue["int"] is Int)
        XCTAssert(dictionaryValue["double"] is Double)
        XCTAssert(dictionaryValue["bool"] is Bool)
    }
}
