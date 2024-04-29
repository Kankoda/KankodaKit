//
//  AppItemContextStore.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023 Kankoda. All rights reserved.
//

import Foundation

/// This store will keep a context in sync with a base store.
///
/// Note that the store reads the entire store at start then
/// syncs it with the context. Although it is done async, it
/// is not recommended for a large amount of data.
open class AppItemContextStore<
    Item: AppItem,
    BaseStore: AppItemStore,
    Context: AppItemContext>: AppItemStore where BaseStore.Item == Item, Context.Item == Item {

    /// Create a contextual store instance.
    ///
    /// - Parameters:
    ///   - baseStore: The base store to use for storage.
    ///   - context: The context to keep in sync.
    public init(
        baseStore: BaseStore,
        context: Context
    ) {
        self.baseStore = baseStore
        self.context = context
        Task { try? await initializeContext() }
    }

    private let baseStore: BaseStore
    private let context: Context

    public var itemCount: Int {
        baseStore.itemCount
    }

    public func getItems() async throws -> [Item] {
        try await baseStore.getItems()
    }
    
    public func remove(_ item: Item) async throws {
        try await baseStore.remove(item)
        await removeFromContext(item)
    }
    
    public func remove(_ items: [Item]) async throws {
        try await baseStore.remove(items)
        await removeFromContext(items)
    }
    
    public func store(_ item: Item) async throws {
        try await baseStore.store(item)
        await addToContext(item)
    }
    
    public func store(_ items: [Item]) async throws {
        try await baseStore.store(items)
        await addToContext(items)
    }
}

private extension AppItemContextStore {

    func initializeContext() async throws {
        let items = try await baseStore.getItems()
        await initializeContext(with: items)
    }
}

@MainActor
private extension AppItemContextStore {

    func addToContext(_ item: Item) {
        context.add(item)
    }

    func addToContext(_ items: [Item]) {
        context.add(items)
    }

    func removeFromContext(_ item: Item) {
        context.remove(item)
    }

    func removeFromContext(_ items: [Item]) {
        context.remove(items)
    }

    func initializeContext(with items: [Item]) {
        context.items = items
    }
}
