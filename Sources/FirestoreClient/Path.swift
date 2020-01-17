//
//  Path.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/11/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirebaseFirestore

public protocol Path {
    var value: String { get }
    init(_ value: String)
}

// MARK: - Collection

public final class Collection: Path {
    public private(set) var value: String
    
    public init(_ value: String) {
        self.value = value
    }
    
    public func document(_ path: String) -> Document {
        .init([value, path].joined(separator: "/"))
    }
}

// MARK: - Document

public final class Document: Path {
    public private(set) var value: String
    
    public init(_ value: String) {
        self.value = value
    }
    
    public func collection(_ path: String) -> Collection {
        .init([value, path].joined(separator: "/"))
    }
}
