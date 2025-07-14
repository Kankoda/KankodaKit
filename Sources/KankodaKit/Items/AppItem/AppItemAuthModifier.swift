//
//  AppItemAuthModifier.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-07-13.
//  Copyright © 2022-2025 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
import SwiftUI
import SwiftUIKit

/// This modifier makes the view request authentication when
/// it appears and the app starts, then reset authentication
/// state when the app moves into the background.
///
/// Note that only a single view in the app should use this.
struct AppItemAuthModifier: ViewModifier {

    /// Create an authentication view modifier.
    ///
    /// - Parameters:
    ///   - reason: The authentication reason to show the user, by default the app unlock message.
    ///   - notificationCenter: The notification center to use, by default `.default`.
    init(
        authReason: String,
        notificationCenter: NotificationCenter = .default
    ) {
        self.authReason = authReason
        self.center = notificationCenter
    }

    private let authReason: String
    private let center: NotificationCenter

    @Environment(AppItemAuthContext.self)
    private var authContext

    func body(content: Content) -> some View {
        content.onAppear { authenticateUser() }
            .onReceive(center.backgroundPublisher) { _ in resetAuthentication() }
            .onReceive(center.foregroundPublisher) { _ in authenticateUser() }
    }
}

public extension View {

    /// This modifier makes a view request authentication as
    /// the app launches, then reset authentication when the
    /// app moves to the background.
    ///
    /// - Parameters:
    ///   - reason: The authentication reason to show the user, by default the app unlock message.
    ///   - notificationCenter: The notification center to use, by default `.default`.
    func withAppItemAuthentication(
        authReason: String,
        notificationCenter: NotificationCenter = .default
    ) -> some View {
        self.modifier(
            AppItemAuthModifier(
                authReason: authReason,
                notificationCenter: notificationCenter
            )
        )
    }
}

private extension AppItemAuthModifier {

    func authenticateUser() {
        guard authContext.isAuthenticationActive else { return }
        resetAuthentication()
        authContext.authenticateUser(reason: authReason)
    }

    func resetAuthentication() {
        authContext.reset()
    }
}

private extension NotificationCenter {

    var backgroundPublisher: NotificationCenter.Publisher {
        #if os(iOS) || os(visionOS) || os(tvOS)
        publisher(for: UIApplication.didEnterBackgroundNotification)
        #elseif os(macOS)
        publisher(for: NSApplication.didHideNotification)
        #elseif os(watchOS)
        publisher(for: WKExtension.applicationDidEnterBackgroundNotification)
        #endif
    }

    var foregroundPublisher: NotificationCenter.Publisher {
        #if os(iOS) || os(visionOS) || os(tvOS)
        publisher(for: UIApplication.willEnterForegroundNotification)
        #elseif os(macOS)
        publisher(for: NSApplication.didUnhideNotification)
        #elseif os(watchOS)
        publisher(for: WKExtension.applicationWillEnterForegroundNotification)
        #endif
    }
}
#endif
