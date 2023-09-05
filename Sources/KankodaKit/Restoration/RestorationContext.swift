//
//  AppScreenRestoration.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-09-05.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This class can be used to restore the last "something" like
 an app screen or something like that.
 
 To use the class, just provide it with a list of restorable
 values, then call ``tryUpdateItem(_:)`` with values of this
 type. If the item is in the original list, it will be saved
 for later and can be restored with ``tryRestoreItem()``.
 
 For now, because of `AppStorage` the `ID` must be a `String`.
 */
public class RestorationContext<Item: Identifiable & Equatable>: ObservableObject where Item.ID == String {
    
    public init(restorableItems items: [Item]) {
        self.items = items
    }
    
    private let items: [Item]
    
    @AppStorage("com.kankoda.restoration.id")
    private var lastId: Item.ID?
    
    public func tryRestoreItem() -> Item? {
        items.first { $0.id == lastId }
    }
 
    public func tryUpdateItem(_ item: Item?) {
        guard let item else { return }
        guard items.contains(item) else { return }
        lastId = item.id
    }
}
