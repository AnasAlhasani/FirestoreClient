//
//  RequestBuilderTests.swift
//  FirestoreClientTests
//
//  Created by Anas Alhasani on 1/3/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import XCTest
@testable import FirestoreClient

final class RequestBuilderTests: XCTestCase {
    
    func testRequestBuilder() {
        let expectedCollectionPath = "collection"
        let expectedDocumentPath = "document"
        let expectedEntity = TestEntity.create()
        
        let request = RequestBuilder<TestEntity>()
            .with(\.collectionPath, "collection")
            .with(\.documentPath, "document")
            .with(\.data, expectedEntity)
        
        XCTAssertEqual(expectedCollectionPath, request.collectionPath)
        XCTAssertEqual(expectedDocumentPath, request.documentPath)
        XCTAssertEqual(expectedEntity, request.data as? TestEntity)
    }
}
