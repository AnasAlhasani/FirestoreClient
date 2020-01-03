//
//  Commons.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/3/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
@testable import FirestoreClient

// MARK: - TestRequest
final class TestRequest<T: Entity>: Request, Buildable {
    typealias Entity = T
    
    var collectionPath = ""
    var documentPath = ""
    var data: Encodable?
}

// MARK: - TestEntity

struct TestEntity: Entity, Equatable {
    let string: String
    let int: Int
    let double: Double
    let bool: Bool
}

extension TestEntity {
    static func create() -> TestEntity {
        .init(
            string: "Hello, world!",
            int: 1,
            double: 10.0,
            bool: true
        )
    }
}

// MARK: - TestError

struct TestError: Error, Equatable {
    
}

// MARK: - CoreError

extension CoreError: Equatable {
    public static func == (lhs: CoreError, rhs: CoreError) -> Bool {
        String(describing: lhs) == String(describing: rhs)
    }
}
