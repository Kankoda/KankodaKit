//
//  MemoryAppItemStore.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This store stores items in working memory. Only use it when
 testing or previewing, since it will reset on app restart.
 */
public class MemoryAppItemStore<Item: AppItem>: AppItemStore {

    /**
     Create a memory store instance.

     - Parameters:
     - items: The initial collection of items in the store.
     */
    public init(items: [Item] = []) {
        self.items = items
    }

    private var items: [Item]

    public var itemCount: Int {
        items.count
    }

    public func getItems() async throws -> [Item] {
        items
    }

    public func remove(_ item: Item) async throws {
        items.removeAll { $0.id == item.id }
    }

    public func remove(_ items: [Item]) async throws {
        for item in items {
            try await remove(item)
        }
    }

    public func store(_ item: Item) async throws {
        try await remove(item)
        items.append(item)
    }

    public func store(_ items: [Item]) async throws {
        for item in items {
            try await store(item)
        }
    }
}
