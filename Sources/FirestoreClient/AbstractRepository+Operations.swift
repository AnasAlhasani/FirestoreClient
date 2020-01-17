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

// MARK: - Read Operations

public extension AbstractRepository {
    func query(builder: @escaping QueryHandler<Value>) -> Promise<[Value]> {
        let collection = database.collection(path.value)
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
    
    func fetch(path: Path) -> Promise<Value> {
        let document = database.document(path.value)
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

// MARK: - Write Operations

public extension AbstractRepository {
    func save(entity: Encodable) -> Promise<Void> {
        do {
            let document = database.document(path.value)
            let json = try entity.jsonDictionary()
            return Promise(on: .global(qos: .background)) { fullfill, reject in
                document.setData(json, merge: false) { error in
                    if let error = error {
                        reject(error)
                    } else {
                        fullfill(())
                    }
                }
            }
        } catch {
            return .init(error)
        }
    }
    
    func update(entity: Encodable) -> Promise<Void> {
        do {
            let document = database.document(path.value)
            let json = try entity.jsonDictionary()
            return Promise(on: .global(qos: .background)) { fullfill, reject in
                document.updateData(json) { error in
                    if let error = error {
                        reject(error)
                    } else {
                        fullfill(())
                    }
                }
            }
        } catch {
            return .init(error)
        }
    }
    
    func delete(path: Path) -> Promise<Void> {
        let document = database.document(path.value)
        return Promise(on: .global(qos: .background)) { fullfill, reject in
            document.delete { error in
                if let error = error {
                    reject(error)
                } else {
                    fullfill(())
                }
            }
        }
    }
}

// MARK: - Helpers

private extension AbstractRepository {
    var database: Firestore {
        .firestore()
    }
    
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
