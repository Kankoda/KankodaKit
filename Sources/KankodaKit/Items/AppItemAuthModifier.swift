//
//  AppItemAuthModifier.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-07-13.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit

/**
 This modifier can be applied to any view, and will make the
 view request authentication when the app starts, then reset
 authentication when it moves to the background.

 Note that only a single app should use this, preferably the
 application root view.
 */
struct AppItemAuthModifier: ViewModifier {

    /**
     Create an authentication view modifier.

     - Parameters:
       - reason: The authentication reason to show the user, by default the app unlock message.
       - notificationCenter: The notification center to use, by default `.default`.
     */
    init(
        authReason: String,
        notificationCenter: NotificationCenter = .default
    ) {
        self.authReason = authReason
        self.center = notificationCenter
    }

    private let authReason: String
    private let center: NotificationCenter

    @EnvironmentObject
    private var authContext: AppItemAuthContext

    @EnvironmentObject
    private var sheet: SheetContext

    func body(content: Content) -> some View {
        content.onAppear { authenticateUser() }
            .onReceive(center.backgroundPublisher) { _ in resetAuthentication() }
            .onReceive(center.foregroundPublisher) { _ in authenticateUser() }
    }
}

public extension View {

    /**
     This modifier will make the view request authentication
     when an app launches, then reset authentication when it
     moves to the background.
     
     Only a single view should use this, preferably the root.
     
     - Parameters:
       - reason: The authentication reason to show the user, by default the app unlock message.
       - notificationCenter: The notification center to use, by default `.default`.
     */
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
        guard authContext.isAuthenticationEnabled else { return }
        resetAuthentication()
        authContext.authenticateUser(reason: authReason)
    }

    func resetAuthentication() {
        sheet.dismiss()
        authContext.resetAuthentication()
    }
}

#if os(iOS)
private extension NotificationCenter {

    var backgroundPublisher: NotificationCenter.Publisher {
        publisher(for: UIApplication.didEnterBackgroundNotification)
    }

    var foregroundPublisher: NotificationCenter.Publisher {
        publisher(for: UIApplication.willEnterForegroundNotification)
    }
}
#endif

#if os(macOS)
private extension NotificationCenter {

    var backgroundPublisher: NotificationCenter.Publisher {
        publisher(for: NSApplication.didHideNotification)
    }

    var foregroundPublisher: NotificationCenter.Publisher {
        publisher(for: NSApplication.didUnhideNotification)
    }
}
#endif
