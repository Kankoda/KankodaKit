//
//  AppEnvironment.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//  Copyright © 2024-2026 Kankoda. All rights reserved.
//

import StoreKitPlus
import SwiftUI

/// This class can be used to manage static app dependencies.
///
/// The class defines a standard set of values, which can be
/// extended by an app to add singletons and resolvers to it.
public final class AppEnvironment {}

@MainActor
public extension AppEnvironment {

    static let storeContext = StoreContext()
}

public extension View {

    /// Apply all standard ``AppEnvironment`` objects.
    func withKankodaAppEnvironment() -> some View {
        self.environmentObject(AppEnvironment.storeContext)
    }
}
