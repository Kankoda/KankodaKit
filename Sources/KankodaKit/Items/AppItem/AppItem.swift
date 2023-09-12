//
//  AppItem.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import CoreTransferable
import Foundation

/**
 This protocol describes an named item that can be persisted
 and used in an app, such as wallet items in Wally.
 */
public protocol AppItem: Codable, Equatable, Identifiable, Named, Transferable {
    
    /// The unique item id.
    var id: UUID { get }
    
    /// The type name, e.g. "Card".
    static var typeName: String { get }
    
    /// The type's plural name, e.g. "Cards".
    static var typePluralName: String { get }
    
    /// Create an empty placeholder item.
    static func placeholderItem() -> Self
}

public extension AppItem {
    
    /// The display name, resolves to ``nameWithTypeFallback``.
    var displayName: String {
        nameWithTypeFallback
    }
    /// Get the name of the item, with the type name if none.
    var nameWithTypeFallback: String {
        name(fallback: Self.typeName)
    }
}

public extension Array where Element: AppItem {

    /// Get items at a certain index set in the array.
    func items(at indexSet: IndexSet) -> [Element] {
        let indices = indexSet.filter { $0 < count }
        return indices.compactMap { self[$0] }
    }
}
