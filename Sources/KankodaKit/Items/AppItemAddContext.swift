//
//  AppItemAddContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-15.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any context that can be
 used when adding a new item.
 */
public protocol AppItemAddContext: ObservableObject {

    associatedtype Item: AppItem

    var item: Item? { get }
}

public extension AppItemAddContext {

    var hasItem: Bool {
        item != nil
    }
}
