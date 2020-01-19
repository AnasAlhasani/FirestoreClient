//
//  CoreError.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/1/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation

public enum CoreError: Error, LocalizedError {
    case decodableMapping
    case encodableMapping
    case jsonMapping
    case underlying(Error)
    case snapshotNotExists
    case invalidInputCombination
    case unknown
}

public extension CoreError {
    var errorDescription: String? {
        switch self {
        case let .underlying(error): return error.localizedDescription
        case .decodableMapping: return "Failed to map data to a Decodable object."
        case .encodableMapping: return "Failed to encode Encodable object into data."
        case .jsonMapping: return "Failed to map data to JSON."
        case .snapshotNotExists: return "Snapshot dose not exists."
        case .invalidInputCombination: return "Invalid input combination."
        case .unknown: return "Something went wrong."
        }
    }
}
