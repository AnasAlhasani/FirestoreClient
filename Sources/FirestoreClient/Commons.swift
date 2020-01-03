//
//  Types.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/1/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import Promises

// MARK: - Typealias

public typealias Promise<T> = Promises.Promise<T>
public typealias Result<T> = Swift.Result<T, Error>
public typealias JSONDictionary = [String: Any]
public typealias JSONArray = [JSONDictionary]

// MARK: - Extensions

extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}

extension Encodable {
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonDictionary() throws -> JSONDictionary {
        let data: Data = try encoded()
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        guard JSONSerialization.isValidJSONObject(jsonObject),
            let jsonDictionary = jsonObject as? JSONDictionary
        else {
            throw CoreError.jsonMapping
        }
        return jsonDictionary
    }
}

// MARK: - Result Factory

func makeResult<T, E: Error>(_ value: T?, _ error: E?) -> Result<T> {
    switch (value, error) {
    case let (.some(value), .none):
        return .success(value)
    case let (.none, .some(error)):
        return .failure(error)
    default:
        return .failure(CoreError.invalidInputCombination)
    }
}
