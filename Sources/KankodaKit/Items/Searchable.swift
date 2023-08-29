//
//  Searchable.swift
//  WallyKit
//
//  Created by Daniel Saidi on 2022-08-09.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by types that can have one
 or multiple tags, which can be used to group, search etc.
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
