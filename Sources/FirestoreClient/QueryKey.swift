//
//  QueryKey.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/2/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation

public protocol QueryKey {
    static var keys: [PartialKeyPath<Self>: CodingKey] { get }
}

extension QueryKey where Self: Codable {
    static func key(from keyPath: PartialKeyPath<Self>) -> String? {
        return keys[keyPath]?.stringValue
    }
}
