//
//  Sortable.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-06.
//  Copyright © 2022-2025 Kankoda. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any sortable type.
public protocol Sortable {

    /// The sortable value's sort order.
    var sortOrder: UInt { get set }
}

public extension Collection where Element: Sortable {

    /// Get the min sort order in the collection.
    var minSortOrder: UInt {
        map { $0.sortOrder }.min() ?? 0
    }

    /// Get the max sort order in the collection.
    var maxSortOrder: UInt {
        map { $0.sortOrder }.max() ?? 0
    }

    /// Whether or not the sort order must be refreshed.
    var needsRefreshedSortOrder: Bool {
        let values = Set(map { $0.sortOrder })
        return values.count < count
    }

    /// Sort the collection using the item sort order.
    func sortedBySortOrder() -> [Element] {
        sorted { $0.sortOrder < $1.sortOrder }
    }

    /// Refresh the sort order of items in the collection.
    func withRefreshedSortOrder() -> [Element] {
        enumerated().map {
            var item = $0.element
            item.sortOrder = UInt($0.offset)
            return item
        }
    }
}
