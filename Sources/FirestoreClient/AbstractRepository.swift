//
//  AbstractRepository.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/4/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation

public protocol AbstractRepository {
    associatedtype Value: Codable
    associatedtype Query: Codable & QueryKey
    
    var path: Path { get }
    
    func query(builder: @escaping QueryHandler<Query>) -> Promise<[Query]>
    func fetch(path: Path) -> Promise<Value>
    func save(entity: Encodable) -> Promise<Void>
    func update(entity: Encodable) -> Promise<Void>
    func delete(path: Path) -> Promise<Void>
}
