//
//  AdminContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-01.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
//

import SwiftUI
import ObservablePersistency

/// This class can manage the admin mode of an app.
@Observable
public class AdminContext: ObservablePersisted {

    private static let adminKey = key(PackageInfo.appStorageKey("admin.isAdminModeEnabled"), default: false)

    /// Whether or not admin mode is enabled.
    public var isAdminModeEnabled = getValue(for: adminKey) {
        didSet { setValue(isAdminModeEnabled, for: Self.adminKey) }
    }
}

public extension AdminContext {

    func reset() {
        isAdminModeEnabled = false
    }
}
