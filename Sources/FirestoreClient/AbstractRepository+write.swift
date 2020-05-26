//
//  AbstractRepository+write.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/18/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirebaseFirestore

// MARK: - Write Operations

public extension AbstractRepository {
    func save(entity: Entity, handler: @escaping ResultHandler<Void>) {
        do {
            let document = path.documentReference()
            var json = try entity.jsonDictionary()
            json[FieldName.id.rawValue] = document.documentID
            document.setData(json, merge: false) { handler(makeResult($0)) }
        } catch {
            handler(.failure(error))
        }
    }
    
    func update(entity: Entity, handler: @escaping ResultHandler<Void>) {
        do {
            let document = path.documentReference(id: entity.id.rawValue)
            let json = try entity.jsonDictionary()
            document.updateData(json) { handler(makeResult($0)) }
        } catch {
            handler(.failure(error))
        }
    }
    
    func delete(byID id: ID, handler: @escaping ResultHandler<Void>) {
        let document = path.documentReference(id: id.rawValue)
        document.delete { handler(makeResult($0)) }
    }
}
