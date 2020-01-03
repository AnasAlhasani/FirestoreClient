//
//  DatabaseReference+Extensions.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/1/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirebaseFirestore

internal struct DatabaseReference {
    let collection: CollectionReference
    let document: DocumentReference
}
