//
//  Request.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/1/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation

public protocol Request {
    var collectionPath: String { get }
    var documentPath: String { get }
    var data: Encodable? { get }
}

public final class RequestBuilder<T: Entity>: Request {
    public typealias Value = T
    
    public var collectionPath = ""
    public var documentPath = ""
    public var data: Encodable?
    
    public init() {
        
    }
}

extension RequestBuilder: Buildable { }
