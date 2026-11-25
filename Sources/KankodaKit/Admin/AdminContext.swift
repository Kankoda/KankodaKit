//
//  AdminContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-01.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import SwiftUI

/// This class can manage the admin mode of an app.
@Observable
public class AdminContext {

    public init(store: UserDefaults = .standard) {
        self.store = store
        self.isAdminModeEnabled = store.bool(forKey: Self.adminKey)
    }

    @ObservationIgnored
    private let store: UserDefaults

    private static let adminKey = PackageInfo.appStorageKey("admin.isAdminModeEnabled")

    /// Whether or not admin mode is enabled.
    public var isAdminModeEnabled: Bool {
        didSet { store.set(isAdminModeEnabled, forKey: Self.adminKey) }
    }
}

public extension AdminContext {

    func reset() {
        isAdminModeEnabled = false
    }
}
