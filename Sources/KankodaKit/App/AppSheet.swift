//
//  AppSheet.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//  Copyright © 2024-2025 Kankoda. All rights reserved.
//

import PresentationKit
import SwiftUI

/// This sheet container wraps another view content within a
/// navigation stack, applies a new sheet to it, and applies
/// a view environment to the wrapped content.
public struct AppSheet<Content: View, Output: View>: View {

    public init(
        @ViewBuilder content: @escaping () -> Content,
        appEnvironment: @escaping (SheetContent) -> Output
    ) {
        self.content = content
        self.appEnvironment = appEnvironment
    }

    public typealias SheetContent = AppSheetContent<Content>

    private let content: () -> Content
    private let appEnvironment: (SheetContent) -> Output

    public var body: some View {
        NavigationStack {
            appEnvironment(
                AppSheetContent(content)
            )
        }
    }
}

/// This is an internally used content wrapper, that applies
/// a new sheet context to the wrapped content.
public struct AppSheetContent<Content: View>: View {

    public init(
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.content = content
    }

    private let content: () -> Content

    @StateObject var sheet = AnySheetContext()

    public var body: some View {
        content().sheet(sheet)
    }
}

@MainActor
public extension AnySheetContext {

    /// Present an app sheet content view.
    ///
    /// This can be specialized in each app, by using an app
    /// specific app screen type.
    func presentAppScreen<Content: View, Output: View>(
        @ViewBuilder content: @escaping () -> Content,
        appEnvironment: @escaping (AppSheetContent<Content>) -> Output,
        onDismiss: @escaping () -> Void = {}
    ) {
        present(
            AppSheet(
                content: content,
                appEnvironment: appEnvironment
            )
            .onDisappear(perform: onDismiss)
        )
    }
}

#Preview {

    struct Preview: View {

        @EnvironmentObject var sheet: AnySheetContext

        var body: some View {
            Button("Open Sheet") {
                sheet.present(
                    AppSheet {
                        Text("Sheeeeeet")
                            .navigationTitle("Yeah")
                    } appEnvironment: { view in
                        view
                            .background(Color.red)
                            #if os(iOS)
                            .navigationBarTitleDisplayMode(.inline)
                            #endif
                    }
                )
            }
        }
    }

    return AppSheet {
        Preview()
    } appEnvironment: { view in
        view.background(Color.yellow)
    }
}
