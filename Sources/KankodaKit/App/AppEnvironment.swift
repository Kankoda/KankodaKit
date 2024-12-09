//
//  AppEnvironment.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//  Copyright © 2024 Kankoda. All rights reserved.
//

import StoreKitPlus
import SwiftUI
import SwiftUIKit
import SystemNotification

/// This class can be used to manage static app dependencies.
///
/// The class defines a standard set of values, which can be
/// extended by an app as needed.
///
/// > Important: Don't use the same sheet context within new
/// sheets. Instead, make sure to inject a new sheet context
/// to ensure that a new sheet is presented.
public final class AppEnvironment {}

public extension AppEnvironment {

    static let alertContext = AlertContext()
    static let sheetContext = SheetContext()
    static let storeContext = StoreContext()
    static let systemNotificationContext = SystemNotificationContext()
}

public extension View {

    /// Apply the app environment objects.
    func withAppEnvironment(
        appSpecific: (Self) -> some View
    ) -> some View {
        appSpecific(self)
            .environmentObject(AppEnvironment.alertContext)
            .environmentObject(AppEnvironment.sheetContext)
            .environmentObject(AppEnvironment.storeContext)
            .environmentObject(AppEnvironment.systemNotificationContext)
    }
}

#Preview {

    struct Preview: View {

        var body: some View {
            PreviewContent()
                .withAppEnvironment { content in
                    content.background(Color.yellow)
                }
        }
    }

    struct PreviewContent: View {

        @EnvironmentObject var alertContext: AlertContext
        @EnvironmentObject var sheetContext: SheetContext
        @EnvironmentObject var storeContext: StoreContext
        @EnvironmentObject var systemNotificationContext: SystemNotificationContext

        var body: some View {
            Button("Show Sheet") {
                sheetContext.present(Color.red)
            }
            .sheet(sheetContext)
        }
    }

    return Preview()
}
