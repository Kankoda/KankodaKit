//
//  AppItemContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol describes an ``AppItem`` context, that can be
 used to store items.
 
 Only use this approach for limited amounts of data. If your
 app needs a LOT of data, consider using databases.
 */
public protocol AppItemContext: ObservableObject {

    associatedtype Item: AppItem

    /// The items that are handled by the context.
    var items: [Item] { get set }
}

public extension AppItemContext {

    /// Whether or not the context has any items.
    var hasItems: Bool { !items.isEmpty }

    /// Whether or not the context has multiple items.
    var hasMultipleItems: Bool { items.count > 1 }

    /// Add an item to the context.
    func add(_ item: Item) {
        remove(item)
        items.append(item)
    }
    
    /// Add multiple items to the context.
    func add(_ items: [Item]) {
        items.forEach(add)
    }
    
    /// Try getting an item with a certain ID.
    func item(withId id: Item.ID) -> Item? {
        items.first { $0.id == id }
    }

    /// Remove an item from the context.
    func remove(_ item: Item) {
        items.removeAll { $0.id == item.id }
    }

    /// Remove multiple items from the context.
    func remove(_ items: [Item]) {
        items.forEach(remove)
    }
}
