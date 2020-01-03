//
//  AbstractRepository.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/4/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation

public protocol AbstractRepository {
    associatedtype Value: Entity
    
    func query(_ request: Request, builder: @escaping QueryHandler<Value>) -> Promise<[Value]>
    func fetch(_ request: Request) -> Promise<[Value]>
    func save(_ request: Request) -> Promise<Void>
    func update(_ request: Request) -> Promise<Void>
    func delete(_ request: Request) -> Promise<Void>
}
