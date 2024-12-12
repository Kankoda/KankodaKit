//
//  Searchable.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-10-14.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be
/// searched for with a text query.
///
/// Each type can define a list of ``searchComponents`` that
/// will then be included when using ``matches(_:)`` to see
public protocol Searchable {

    /// A list of components to include in the search.
    var searchComponents: [String] { get }
}

public extension Searchable {

    /// Check if the item matches the provided search query.
    func matches(query: String) -> Bool {
        searchComponents.contains {
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
