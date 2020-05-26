//
//  QueryKey.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/2/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation

public protocol QueryKey {
    typealias Keys = [PartialKeyPath<Self>: CodingKey]
    
    static var keys: Keys { get }
}

extension QueryKey where Self: Codable {
    static func key(from keyPath: PartialKeyPath<Self>) -> String? {
        return keys[keyPath]?.stringValue
    }
}
