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
    func save(entity: Encodable) -> Promise<Void> {
        do {
            let document = path.documentReference()
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
            let document = path.documentReference()
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
    
    func delete(byID id: String) -> Promise<Void> {
        let document = path.documentReference(id: id)
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
