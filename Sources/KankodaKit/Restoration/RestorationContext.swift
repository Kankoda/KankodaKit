//
//  AppScreenRestoration.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-09-05.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import SwiftUI

/// This class can be used to restore something, like an app
/// screen or something like that.
///
/// To use the class, just pass in a list of restorable item
/// values, then call ``tryUpdateItem(_:)``. If that item is
/// in the original list, it will be saved for later and can
/// be restored with ``tryRestoreItem()``.
public class RestorationContext<Item: Identifiable & Equatable>: ObservableObject where Item.ID == String {
    
    public init(restorableItems items: [Item]) {
        self.items = items
    }
    
    private let items: [Item]
    
    @AppStorage("com.kankoda.restoration.id")
    private var lastId: Item.ID?
}

public extension RestorationContext {
    
    func tryRestoreItem() -> Item? {
        items.first { $0.id == lastId }
    }
 
    func tryUpdateItem(_ item: Item?) {
        guard let item, items.contains(item) else { return }
        lastId = item.id
    }
}
