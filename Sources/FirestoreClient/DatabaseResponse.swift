//
//  DatabaseResponse.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/1/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

public protocol DatabaseResponse: Codable {
    
}

public struct VoidEntity: DatabaseResponse {
    
}
