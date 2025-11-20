//
//  AppSheet.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//  Copyright © 2024-2025 Kankoda. All rights reserved.
//

import PresentationKit
import SwiftUI

/// This view wraps any view within a navigation stack, then applies a new sheet
/// context to the new hierarchy.
public struct AppSheet<Content: View>: View {

    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }

    private let content: () -> Content

    @StateObject var sheet = AnySheetContext()

    public var body: some View {
        NavigationStack {
            content()
                .sheet(sheet)
        }
    }
}

@MainActor
public extension AnySheetContext {

    /// Present an app sheet content view.
    ///
    /// This wrap the content view in an ``AppSheet``, which wraps the view
    /// in a navigation stack then sets up and injects a new sheet context.
    func presentAppScreen<Content: View, Sheet: View>(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder sheet: @escaping (AppSheet<Content>) -> Sheet,
        onDismiss: @escaping () -> Void = {}
    ) {
        present(
            sheet(
                AppSheet(content: content)
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
                    }
                )
            }
        }
    }

    return AppSheet {
        Preview()
    }
}
