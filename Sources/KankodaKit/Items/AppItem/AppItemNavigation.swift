//
//  AppItemNavigationContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-09-02.
//  Copyright © 2023 Kankoda. All rights reserved.
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
}

public extension AppItemNavigation {
    
    /// Whether or not the navigation has an item.
    var hasItem: Bool {
        item != nil
    }
    
    /// Reset the navigation.
    func reset() {
        item = nil
    }
    
    /// Show a wallet item.
    func present(_ item: any AppItem) {
        self.item = item
    }
}
