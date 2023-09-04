//
//  AppItemNavigationContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-09-02.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This class can be used to describe a navigation destination
 for a certain ``AppItem``.
 
 This can for instance be used by an intent-based navigation.
 */
@MainActor
public class AppItemNavigation: ObservableObject {
    
    public init() {}
    
    public static let shared = AppItemNavigation()
    
    @Published
    public var item: (any AppItem)?
    
    /// Whether or not the navigation has an item.
    public var hasItem: Bool {
        item != nil
    }
    
    /// Reset the navigation.
    public func reset() {
        item = nil
    }
    
    /// Show a wallet item.
    public func present(_ item: any AppItem) {
        self.item = item
    }
}
