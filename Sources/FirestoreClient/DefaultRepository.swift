//
//  DefaultRepository.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/18/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirebaseFirestore

public final class DefaultRepository<E>: AbstractRepository where E: Entity {
    public typealias Entity = E
    
    public let path: Path
    
    public init(path: Path) {
        self.path = path
    }
}
