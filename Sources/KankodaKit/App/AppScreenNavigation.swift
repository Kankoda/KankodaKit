//
//  AppScreenNavigation.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-01-13.
//

import PresentationKit
import SwiftUI

/// This navigation stack view can manage the navigation for
/// any type that implements ``AppScreenType``.
public struct AppScreenNavigationStack<ScreenType: AppScreenType>: View {

    public init(
        _ screenType: ScreenType
    ) {
        self.screenType = screenType
    }

    private let screenType: ScreenType

    @State var navigationContext = NavigationContext<ScreenType>()

    public var body: some View {
        NavigationStack(path: $navigationContext.path) {
            screenType.screenContent
                .environment(navigationContext)
                .navigationDestination(for: ScreenType.self) {
                    $0.screenContent
                }
        }
    }
}
