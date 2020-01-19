//
//  Entity.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/19/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import Identity

public protocol Entity: Codable, Identifiable where RawIdentifier == String {
    
}
