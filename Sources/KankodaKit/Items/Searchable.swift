//
//  Searchable.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-09.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by searchable data types.
 */
public protocol Searchable {

    /// Whether or not the value matches a certain query.
    func matches(searchQuery: String) -> Bool
}

public extension Collection where Element: Searchable {

    /// Get all values that match a certain search qeuery.
    func matching(searchQuery: String) -> [Element] {
        filter { $0.matches(searchQuery: searchQuery) }
    }
}
