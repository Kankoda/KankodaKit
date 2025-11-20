//
//  AppRootView.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
//

import PresentationKit
import StoreKitPlus
import SwiftUI
import SwiftUIKit

/// This view can be used as the root view of an app.
///
/// The view applies alert, sheet and system notification contexts to the view, and
/// syncs store data with the store service every time the app becomes active.
///
/// To ensure that everything is correctly set up, the view assumes that it's set up
/// with ``SwiftUICore/View/withAppEnvironment(appSpecific:)``.
/// It will sync in-app purchases and subscriptions if a store service is provided.
public struct AppRootView<Content: View>: View {

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

    @EnvironmentObject public var alert: AnyAlertContext
    @EnvironmentObject public var sheet: AnySheetContext
    @EnvironmentObject public var storeContext: StoreContext

    public var body: some View {
        content()
            .alert(alert)
            .sheet(sheet)
            .onChange(of: scenePhase) { _, phase in syncStoreData(for: phase) }
    }
}

private extension AppRootView {
    
    func syncStoreData(for phase: ScenePhase) {
        guard phase == .active else { return }
        guard let storeService else { return }
        Task {
            try await storeService.syncStoreData(to: storeContext)
        }
    }
}

#Preview {
    AppRootView(storeService: nil) {
        Color.green
    }
    .withKankodaAppEnvironment()
}
