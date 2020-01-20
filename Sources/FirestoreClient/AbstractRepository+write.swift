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
    @discardableResult
    func save<E: Entity>(entity: E) -> Promise<Void> {
        do {
            let document = path.documentReference()
            var json = try entity.jsonDictionary()
            json[FieldName.id.rawValue] = document.documentID
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
    
    @discardableResult
    func update<E: Entity>(entity: E) -> Promise<Void> {
        do {
            let document = path.documentReference(id: entity.id.rawValue)
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
    
    @discardableResult
    func delete(byID id: Identifier<Value>) -> Promise<Void> {
        let document = path.documentReference(id: id.rawValue)
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
