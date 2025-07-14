//
//  AppItem.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023 Kankoda. All rights reserved.
//

import CoreTransferable
import Foundation

/// This protocol defines named items that can be persisted.
public protocol AppItem: Codable, Equatable, Identifiable, Named, Sendable, Transferable {
    
    /// The unique item id.
    var id: UUID { get }
    
    /// Create an empty placeholder item.
    static func placeholderItem() -> Self
}

public extension Array where Element: AppItem {

    /// Get items at a certain index set in the array.
    func items(at indexSet: IndexSet) -> [Element] {
        let indices = indexSet.filter { $0 < count }
        return indices.compactMap { self[$0] }
    }
}
