//
//  AppEnvironment.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//  Copyright © 2024-2026 Kankoda. All rights reserved.
//

import PresentationKit
import StoreKitPlus
import SwiftUI

/// This class can be used to manage static app dependencies.
///
/// The class defines a standard set of values, which can be extended by an app.
///
/// > Important: Make sure to create a new sheet context when presenting a new
/// sheet, otherwise new sheet presentations will affect the already active sheet.
public final class AppEnvironment {}

@MainActor
public extension AppEnvironment {

    static let alertContext = AnyAlertContext()
    static let sheetContext = AnySheetContext()
    static let storeContext = StoreContext()
}

public extension View {

    /// Apply all standard ``AppEnvironment`` objects.
    func withKankodaAppEnvironment() -> some View {
        self.environmentObject(AppEnvironment.alertContext)
            .environmentObject(AppEnvironment.sheetContext)
            .environmentObject(AppEnvironment.storeContext)
    }
}

#Preview {

    struct Preview: View {

        var body: some View {
            PreviewContent()
                .withKankodaAppEnvironment()
        }
    }

    struct PreviewContent: View {

        @EnvironmentObject var alertContext: AnyAlertContext
        @EnvironmentObject var sheetContext: AnySheetContext
        @EnvironmentObject var storeContext: StoreContext

        var body: some View {
            Button("Show Sheet") {
                sheetContext.present(Color.red.ignoresSafeArea())
            }
            .sheet(sheetContext)
        }
    }

    return Preview()
}
