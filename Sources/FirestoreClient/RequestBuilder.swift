//
//  RequestBuilder.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/3/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation

public final class RequestBuilder<T: DatabaseResponse>: DatabaseRequest {
    public typealias Entity = T
    
    public var collectionPath = ""
    public var documentPath = ""
    public var operation: DatabaseOperation = .retrieve
    
    public init() {
        
    }
}

extension RequestBuilder: Buildable { }
