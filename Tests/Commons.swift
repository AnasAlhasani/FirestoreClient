//
//  Commons.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/3/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirestoreClient

// MARK: - TestEntity

struct TestEntity: Codable, Equatable {
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
