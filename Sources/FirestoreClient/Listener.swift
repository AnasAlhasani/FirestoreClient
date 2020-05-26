//
//  Listener.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 5/26/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirebaseFirestore

public struct Listener {
    public typealias CancelHandler = () -> Void
    
    public let cancel: CancelHandler
    
    public init(cancel: @escaping CancelHandler) {
        self.cancel = cancel
    }
}

extension ListenerRegistration {
    func asListener() -> Listener {
        Listener(cancel: remove)
    }
}
