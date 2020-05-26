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
    func listen(handler: @escaping ResultHandler<[Entity]>) {
        let collection = path.collectionReference
        collection.addSnapshotListener(completion(handler))
    }
    
    func fetch(handler: @escaping ResultHandler<[Entity]>) {
        let collection = path.collectionReference
        collection.getDocuments(completion: completion(handler))
    }
    
    func fetch(byID id: ID, handler: @escaping ResultHandler<Entity>) {
        let document = path.documentReference(id: id.rawValue)
        document.getDocument(completion: completion(handler))
    }
}

public extension AbstractRepository where Entity: QueryKey {
    func listen(
        queryBuilder: @escaping QueryHandler<Entity> = { $0 },
        handler: @escaping ResultHandler<[Entity]>
    ) {
        let collection = path.collectionReference
        let query = queryBuilder(QueryBuilder<Entity>(collection)).build()
        query.addSnapshotListener(completion(handler))
    }
    
    func fetch(
        queryBuilder: @escaping QueryHandler<Entity> = { $0 },
        handler: @escaping ResultHandler<[Entity]>
    ) {
        let collection = path.collectionReference
        let query = queryBuilder(QueryBuilder<Entity>(collection)).build()
        query.getDocuments(completion: completion(handler))
    }
}

// MARK: - Helpers

private extension AbstractRepository {
    func completion(_ handler: @escaping ResultHandler<Entity>) -> FIRDocumentSnapshotBlock {
        return { snapshot, error in
            do {
                let snapshot = try makeResult(snapshot, error).get()
                let value = try Self.makeValue(snapshot)
                handler(.success(value))
            } catch {
                handler(.failure(error))
            }
        }
    }
    
    func completion(_ handler: @escaping ResultHandler<[Entity]>) -> FIRQuerySnapshotBlock {
        return { snapshot, error in
            do {
                let snapshot = try makeResult(snapshot, error).get()
                let values = try Self.makeValues(snapshot)
                handler(.success(values))
            } catch {
                handler(.failure(error))
            }
        }
    }
}

private extension AbstractRepository {
    static func makeValue(_ snapshot: DocumentSnapshot) throws -> Entity {
        guard snapshot.exists else {
            throw CoreError.snapshotNotExists
            
        }
        guard let value = try snapshot.data(as: Entity.self) else {
            throw CoreError.decodableMapping
        }
        return value
    }
    
    static func makeValues(_ snapshot: QuerySnapshot) throws -> [Entity] {
        do {
            return try snapshot.documents.compactMap { try $0.data(as: Entity.self) }
        } catch {
            throw CoreError.decodableMapping
        }
    }
}
