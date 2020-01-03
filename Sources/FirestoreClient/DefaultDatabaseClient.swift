//
//  DefaultDatabaseClient.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/1/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Promises

public final class DefaultDatabaseClient: DatabaseClient {
    
    public let database: Firestore
    public let dispatchQueue: DispatchQueue
    
    public init(
        database: Firestore = .firestore(),
        dispatchQueue: DispatchQueue = .global(qos: .background)
    ) {
        self.database = database
        self.dispatchQueue = dispatchQueue
    }
}

public extension DefaultDatabaseClient {
    func execute<T: DatabaseRequest>(_ request: T) -> Promise<T.Entity> {
        fatalError("Not ready yet.")
    }
}
