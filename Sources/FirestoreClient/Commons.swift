//
//  Types.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/1/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation

// MARK: - Typealias

public typealias Result<T> = Swift.Result<T, Error>
public typealias ResultHandler<T> = (Result<T>) -> Void
public typealias JSONDictionary = [String: Any]
public typealias JSONArray = [JSONDictionary]
public typealias Query = Entity & QueryKey
public typealias QueryHandler<T: Query> = (QueryBuilder<T>) -> QueryBuilder<T>

// MARK: - Constants

enum FieldName: String {
    case id
}

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

func makeResult<E: Error>(_ error: E?) -> Result<Void> {
    if let error = error {
        return .failure(error)
    } else {
        return .success(())
    }
}

// MARK: - Buildable

protocol Buildable { }

extension Buildable where Self: AnyObject {
    func with<T>(
        _ property: ReferenceWritableKeyPath<Self, T>,
        _ value: T
    ) -> Self {
        self[keyPath: property] = value
        return self
    }
}
