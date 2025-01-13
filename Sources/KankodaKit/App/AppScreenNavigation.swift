//
//  AppScreenNavigation.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-01-13.
//

import SwiftUI

/// This class can manage the navigation stack state for any
/// type that implements ``AppScreenType``.
public class AppScreenNavigationContext<ScreenType: AppScreenType>: ObservableObject {
    
    public init() {}

    @Published
    public var path = [ScreenType]()
}

public extension AppScreenNavigationContext {

    /// Pop back a certain number of steps.
    func popBack(_ steps: Int) {
        path.removeLast(steps)
    }
    /// Pop back to the root.
    func popToRoot() {
        path = []
    }

    /// Push a new screen onto the stack.
    func push(_ screen: ScreenType) {
        path.append(screen)
    }
}

/// This navigation stack view can manage the navigation for
/// any type that implements ``AppScreenType``.
public struct AppScreenNavigationStack<ScreenType: AppScreenType>: View {

    public init(_ screen: ScreenType) {
        self.screen = screen
    }

    private let screen: ScreenType

    @StateObject var navigationContext = AppScreenNavigationContext<ScreenType>()

    public var body: some View {
        NavigationStack(path: $navigationContext.path) {
            screen.screenContent
                .standardNavigationDestination(for: ScreenType.self)
        }
    }
}
