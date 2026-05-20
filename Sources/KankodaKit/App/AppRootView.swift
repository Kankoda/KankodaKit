//
//  AppRootView.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//  Copyright © 2024-2026 Kankoda. All rights reserved.
//

import StoreKitPlus
import SwiftUI

/// This view can be used as the root view of an app.
///
/// This view applies Kankoda-specific view modifiers to the
/// app view, and syncs store data when it becomes active.
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

    @EnvironmentObject public var storeContext: StoreContext

    public var body: some View {
        content()
            .onChange(of: scenePhase) { _, phase in syncStoreData(for: phase) }
    }
}

private extension AppRootView {
    
    func syncStoreData(for phase: ScenePhase) {
        guard phase == .active else { return }
        guard let storeService else { return }
        nonisolated(unsafe) let service = storeService
        let context = storeContext
        Task {
            try await service.syncStoreData(to: context)
        }
    }
}

#Preview {
    AppRootView(storeService: nil) {
        Color.green
    }
    .withKankodaAppEnvironment()
}
