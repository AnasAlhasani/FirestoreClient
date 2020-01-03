//
//  AbstractRepository+Operations.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/4/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

public extension AbstractRepository {
    var database: Firestore {
        .firestore()
    }
    
    func query(_ request: Request, builder: @escaping QueryHandler<Value>) -> Promise<[Value]> {
        let reference = database.collection(request.collectionPath)
        let query = builder(QueryBuilder<Value>(reference)).build()
        return Promise { fullfill, reject in
            query.getDocuments { (snapshot, error) in
                do {
                    let documents = try makeResult(snapshot, error).get().documents
                    let items = try documents.compactMap { try $0.data(as: Value.self) }
                    fullfill(items)
                } catch {
                     reject(error)
                }
            }
        }
    }
    
    func fetch(_ request: Request) -> Promise<[Value]> {
        fatalError("Not ready yet.")
    }
    
    func save(_ request: Request) -> Promise<Void> {
        fatalError("Not ready yet.")
    }
    
    func update(_ request: Request) -> Promise<Void> {
        fatalError("Not ready yet.")
    }
    
    func delete(_ request: Request) -> Promise<Void> {
        let collection = database.collection(request.collectionPath)
        let document = collection.document(request.documentPath)
        return Promise { fullfill, reject in
            document.delete { (error) in
                if let error = error {
                    reject(error)
                } else {
                    fullfill(())
                }
            }
        }
    }
}
