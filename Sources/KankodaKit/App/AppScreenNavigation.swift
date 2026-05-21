//
//  AppScreenNavigation.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-01-13.
//  Copyright © 2025-2026 Kankoda. All rights reserved.
//

import PresentationKit
import SwiftUI

/// This navigation stack can manage app-specific navigation.
///
/// This view will render the provided content view inside a
/// ``NavigationContext``-driven navigation stack and inject
/// the navigation context into the environment.
public struct AppScreenNavigationStack<ScreenType: AppScreenType>: View {

    public init(
        _ root: ScreenType
    ) {
        self.root = root
    }

    private let root: ScreenType

    @State var navigation = Navigation<ScreenType>()

    public var body: some View {
        NavigationStack(path: $navigation.path) {
            root.screenContent
                .environment(navigation)
                .navigationDestination(for: ScreenType.self) {
                    $0.screenContent
                        .environment(navigation)
                }
        }
    }
}
