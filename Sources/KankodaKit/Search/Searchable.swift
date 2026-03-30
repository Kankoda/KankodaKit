//
//  Searchable.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-10-14.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be searched for with a
/// regular text query.
///
/// A type can define a list of ``searchComponents`` which are then included
/// when using ``matches(_:)`` to see if a value matches a query.
public protocol Searchable {

    /// A list of components to include in the search.
    var searchComponents: [String] { get }
}

public extension Searchable {

    /// Check if the item matches the provided search query.
    func matches(query: String) -> Bool {
        guard query.hasTrimmedContent else { return true }
        return searchComponents.contains {
            $0.localizedCaseInsensitiveContains(query)
        }
    }
}

public extension Collection where Element: Searchable {

    /// Get all items that matches the provided search query.
    func matching(query: String) -> [Element] {
        filter { $0.matches(query: query) }
    }
}
