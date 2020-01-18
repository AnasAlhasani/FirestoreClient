//
//  AbstractRepository+read.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/18/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// MARK: - Read Operations

public extension AbstractRepository {
    func query(builder: @escaping QueryHandler<Value>) -> Promise<[Value]> {
        let collection = path.collectionReference
        let query = builder(QueryBuilder<Value>(collection)).build()
        return Promise { fullfill, reject in
            query.getDocuments { (snapshot, error) in
                do {
                    let snapshot = try makeResult(snapshot, error).get()
                    let values = try self.makeValues(snapshot)
                    fullfill(values)
                } catch {
                     reject(error)
                }
            }
        }
    }
    
    func fetch(byID id: String) -> Promise<Value> {
        let document = path.documentReference(id: id)
        return Promise(on: .global(qos: .background)) { fullfill, reject in
            document.getDocument { snapshot, error in
                do {
                    let snapshot = try makeResult(snapshot, error).get()
                    let value = try self.makeValue(snapshot)
                    fullfill(value)
                } catch {
                    reject(error)
                }
            }
        }
    }
}

private extension AbstractRepository {
    func makeValue(_ snapshot: DocumentSnapshot) throws -> Value {
        guard snapshot.exists else {
            throw CoreError.snapshotNotExists
        }
        
        guard let value = try snapshot.data(as: Value.self) else {
            throw CoreError.decodableMapping
        }
        
        return value
    }
    
    func makeValues(_ snapshot: QuerySnapshot) throws -> [Value] {
        do {
            return try snapshot.documents.compactMap { try $0.data(as: Value.self) }
        } catch {
            throw CoreError.decodableMapping
        }
    }
}
