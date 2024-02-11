//
//  AppItemStore.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023 Kankoda. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by stores that can store a
 certain ``AppItem`` type.
 */
public protocol AppItemStore: AnyObject {

    /// The item type that is persisted by the store.
    associatedtype Item: AppItem

    /// Get the total number of items in the store.
    var itemCount: Int { get }

    /// Get all items in the store.
    func getItems() async throws -> [Item]

    /// Remove an item from the store.
    func remove(_ item: Item) async throws

    /// Remove multiple items from the store.
    func remove(_ item: [Item]) async throws

    /// Save an item into the store, replacing copies.
    func store(_ item: Item) async throws

    /// Save multiple items into the store, replacing copies.
    func store(_ items: [Item]) async throws
}

public extension AppItemStore {
    
    /// Whether or not the store has any items.
    var hasItems: Bool { itemCount > 0 }
    
    /// Whether or not the store has multiple items.
    var hasMultipleItems: Bool { itemCount > 1 }

    /// Get all items that matches a certain id collection.
    func getItems(for identifiers: [UUID]) async throws -> [Item] {
        try await getItems().filter {
            identifiers.contains($0.id)
        }
    }
    
    /// Import items from an external data source.
    func importItems(
        _ items: [Item]?,
        overwrite: Bool
    ) async throws {
        guard let items else { return }
        let storeIds = try await getItems().map { $0.id }
        let newItems = overwrite ? items : items.filter { !storeIds.contains($0.id) }
        try await store(newItems)
    }
}

public extension AppItemStore where Item: Searchable {
    
    /// Get all items that matches a certain query.
    func getItems(matching query: String) async throws -> [Item] {
        try await getItems().filter {
            $0.matches(searchQuery: query)
        }
    }
}
