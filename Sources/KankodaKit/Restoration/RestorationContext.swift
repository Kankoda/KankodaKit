//
//  AppScreenRestoration.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-09-05.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import SwiftUI

/// This class can be used to restore any kind of data.
public class RestorationContext<Item: Identifiable & Equatable>: ObservableObject where Item.ID == String {
    
    public init(restorableItems items: [Item]) {
        self.items = items
    }
    
    private var items: [Item]

    @AppStorage("com.kankoda.restoration.id")
    private var lastId: Item.ID?
}

public extension RestorationContext {

    /// Try to restore the last item.
    func tryRestoreItem() -> Item? {
        items.first { $0.id == lastId }
    }

    /// Try to update the current item.
    func tryUpdateItem(_ item: Item?) {
        guard let item, items.contains(item) else { return }
        lastId = item.id
    }

    /// Update the restorable item collection.
    func updateRestorableItems(_ items: [Item]) {
        self.items = items
    }
}
