//
//  QueryBuilder.swift
//  FirestoreClient
//
//  Created by Anas Alhasani on 1/1/20.
//  Copyright © 2020 Anas Alhasani. All rights reserved.
//

import Foundation
import FirebaseFirestore

public final class QueryBuilder<T: Query> {
    private var query: FirebaseFirestore.Query
    
    init(_ query: FirebaseFirestore.Query) {
        self.query = query
    }
    
    private func key(from keyPath: PartialKeyPath<T>) -> String {
        return T.key(from: keyPath) ?? ""
    }
    
    func build() -> FirebaseFirestore.Query {
        return query
    }
}

public extension QueryBuilder {
    @discardableResult
    func filter<V: Equatable>(by keyPath: KeyPath<T, V>, equal value: V) -> Self {
        query = query.whereField(key(from: keyPath), isEqualTo: value)
        return self
    }
    
    @discardableResult
    func filter<V: Comparable>(by keyPath: KeyPath<T, V>, isLessThan value: V) -> Self {
        query = query.whereField(key(from: keyPath), isLessThan: value)
        return self
    }
    
    @discardableResult
    func filter<V: Comparable>(by keyPath: KeyPath<T, V>, isLessThanOrEqual value: V) -> Self {
        query = query.whereField(key(from: keyPath), isLessThanOrEqualTo: value)
        return self
    }
    
    @discardableResult
    func filter<V: Comparable>(by keyPath: KeyPath<T, V>, isGreaterThan value: V) -> Self {
        query = query.whereField(key(from: keyPath), isGreaterThan: value)
        return self
    }
    
    @discardableResult
    func filter<V: Comparable>(by keyPath: KeyPath<T, V>, isGreaterThanOrEqual value: V) -> Self {
        query = query.whereField(key(from: keyPath), isGreaterThanOrEqualTo: value)
        return self
    }
    
    @discardableResult
    func filter<V: Equatable>(by keyPath: KeyPath<T, [V]>, arrayContains value: V) -> Self {
        query = query.whereField(key(from: keyPath), arrayContains: value)
        return self
    }
    
    @discardableResult
    func filter<V: Equatable>(by keyPath: KeyPath<T, [V]>, arrayContains value: [V]) -> Self {
        query = query.whereField(key(from: keyPath), arrayContainsAny: value)
        return self
    }
    
    @discardableResult
    func order<V: Equatable>(by keyPath: KeyPath<T, V>, descending: Bool = false) -> Self {
        query = query.order(by: key(from: keyPath), descending: descending)
        return self
    }
    
    @discardableResult
    func limit(to number: Int) -> Self {
        query = query.limit(to: number)
        return self
    }
}
