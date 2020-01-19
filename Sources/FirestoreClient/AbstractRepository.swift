//
//  AbstractRepository.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/4/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import Identity

public protocol AbstractRepository {
    associatedtype Value: Query
    
    var path: Path { get }
    
    func query(builder: @escaping QueryHandler<Value>) -> Promise<[Value]>
    func fetch(byID id: Identifier<Value>) -> Promise<Value>
    func save<E: Entity>(entity: E) -> Promise<Void>
    func update<E: Entity>(entity: E) -> Promise<Void>
    func delete(byID id: Identifier<Value>) -> Promise<Void>
}
