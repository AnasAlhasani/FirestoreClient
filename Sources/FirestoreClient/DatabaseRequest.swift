//
//  DatabaseRequest.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/1/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirebaseFirestore

public protocol DatabaseRequest {
    associatedtype Entity: DatabaseResponse
    
    var collectionPath: String { get }
    var documentPath: String { get }
    var operation: DatabaseOperation { get }
}

extension DatabaseRequest where Entity: QueryKey {
    func query<T: DatabaseClient>(in client: T) -> Query where T.Database == Firestore {
        let database = client.database
        let collection = database.collection(collectionPath)
        return QueryBuilder<Entity>(collection).build()
    }
}
