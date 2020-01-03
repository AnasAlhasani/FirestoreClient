//
//  Commons.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/3/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
@testable import FirestoreClient

struct TestEntity: Codable, Equatable {
    let string: String
    let int: Int
    let double: Double
    let bool: Bool
}

struct TestError: Error, Equatable {
    
}

extension CoreError: Equatable {
    public static func == (lhs: CoreError, rhs: CoreError) -> Bool {
        String(describing: lhs) == String(describing: rhs)
    }
}
