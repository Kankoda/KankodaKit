//
//  AppItemAddContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-15.
//  Copyright © 2022-2025 Kankoda. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any context that can
/// be used to add a new item.
@MainActor
public protocol AppItemAddContext: ObservableObject {

    associatedtype Item: AppItem

    var item: Item? { get }
}

public extension AppItemAddContext {

    var hasItem: Bool {
        item != nil
    }
}
