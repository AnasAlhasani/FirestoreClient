//
//  AbstractRepository.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/4/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation

public protocol AbstractRepository {
    associatedtype Entity: FirestoreClient.Entity
    typealias ID = Identifier<Entity>
    
    var path: Path { get }
}
