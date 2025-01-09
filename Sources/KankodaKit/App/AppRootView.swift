//
//  AppRootView.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//

import StoreKitPlus
import SwiftUI
import SwiftUIKit
import SystemNotification

/// This view can be used as the root view of an app.
///
/// The view will apply alert, sheet and system notification
/// contexts to the view, and sync store data with the store
/// service every time the app becomes active.
///
/// To ensure that everything has been correctly set up, the
/// view assumes that it has been set up by first applying a
/// ``SwiftUICore/View/withAppEnvironment(appSpecific:)`` to
/// it. It will sync in-app purchases and subscriptions if a
/// store service is provided.
public struct AppRootView<Content: View>: View, ErrorAlerter {

    public init(
        storeService: (any StoreService)?,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.storeService = storeService
        self.content = content
    }

    private let storeService: (any StoreService)?
    private let content: () -> Content
    
    @Environment(\.scenePhase) var scenePhase

    @EnvironmentObject public var alert: AlertContext
    @EnvironmentObject public var sheet: SheetContext
    @EnvironmentObject public var storeContext: StoreContext
    @EnvironmentObject public var systemNotification: SystemNotificationContext

    public var body: some View {
        content()
            .alert(alert)
            .sheet(sheet)
            .systemNotification(systemNotification)
            .onChange(of: scenePhase) { _, phase in syncStoreData(for: phase) }
    }
}

private extension AppRootView {
    
    func syncStoreData(for phase: ScenePhase) {
        guard phase == .active else { return }
        guard let storeService else { return }
        tryWithErrorAlert {
            try await storeService.syncStoreData(to: storeContext)
        }
    }
}

#Preview {
    AppRootView(storeService: nil) {
        Color.green
    }
}
