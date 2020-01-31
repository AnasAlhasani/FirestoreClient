//
//  Path.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/11/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirebaseFirestore

public final class Path {
    public private(set) var value: String
    
    public init(_ value: String) {
        self.value = value
    }
    
    public func append(_ path: String) -> Path {
        .init([value, path].joined(separator: "/"))
    }
}

extension Path {
    var collectionReference: CollectionReference {
        Firestore.firestore().collection(value)
    }
    
    func documentReference(id: String? = nil) -> DocumentReference {
        if let id = id {
            return collectionReference.document(id)
        } else {
            return collectionReference.document()
        }
    }
}
