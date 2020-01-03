//
//  DatabaseClient.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/1/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation

public protocol DatabaseClient {
    associatedtype Database
    
    var database: Database { get }
    
    init(database: Database, dispatchQueue: DispatchQueue)
    
    func execute<T: DatabaseRequest>(_ request: T) -> Promise<T.Entity> 
}
