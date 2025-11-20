//
//  AppItemAuthContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-06-30.
//  Copyright © 2022-2025 Kankoda. All rights reserved.
//

#if os(macOS) || os(iOS) || os(watchOS) || os(visionOS)
import LocalAuthentication
import SwiftUI
import SwiftUIKit

/// This class manages authentication for an app that stores sensitive data.
///
/// Authentication is disabled when biometric authentication is not supported, or if
/// it's disabled it in Settings.
@Observable
public class AppItemAuthContext {
    
    /// Create an app item authentication context.
    ///
    /// The `isEnabled` parameter can be used as a main kill switch for the
    /// entire authentication, e.g. if an app provides authentication as a setting.
    /// Authentication can still be unavailable even if `isEnabled` it true, for
    /// instance in previews and on devices that lack biometric authentication.
    ///
    /// - Parameters:
    ///  - isEnabled: Whether authentication is enabled.
    ///  - policy: The local authentication policy to use.
    ///  - stores: The stores to check before enforcint auth.
    public init(
        isEnabled: Bool = true,
        policy: LAPolicy? = nil,
        stores: [any AppItemStore]
    ) {
        self.authPolicy = policy ?? Self.defaultPolicy
        self.stores = stores
        self.isAuthenticationEnabled = isEnabled
        self.isAuthenticationNeeded = isEnabled
        self.isAuthenticationNeeded = isAuthenticationActive && hasItems
    }

    private static var defaultPolicy: LAPolicy {
        #if os(iOS) || os(macOS) || os(visionOS)
        LAPolicy.deviceOwnerAuthenticationWithBiometrics
        #else
        LAPolicy.deviceOwnerAuthenticationWithWristDetection
        #endif
    }

    private let authPolicy: LAPolicy
    private let stores: [any AppItemStore]
    private let defaults = UserDefaults.standard
    
    /// Whether authentication is needed.
    public var isAuthenticationNeeded: Bool
    
    /// Whether authentication is enabled by the user.
    public var isAuthenticationEnabled: Bool
}

public extension AppItemAuthContext {
    
    /// Whether or not authentication is active for the app.
    var isAuthenticationActive: Bool {
        guard isAuthenticationEnabled else { return false }
        if ProcessInfo.isSwiftUIPreview { return false }
        return LAContext().canEvaluatePolicy(authPolicy, error: nil)
    }
}

@MainActor
public extension AppItemAuthContext {

    /// Try to authenticate the user, provided that it's needed.
    func authenticateUser(reason: String) {
        guard isAuthenticationNeeded else { return }
        Task {
            let result = try await LAContext().evaluatePolicy(authPolicy, localizedReason: reason)
            update(isNeeded: !result)
        }
    }

    /// Reset authentication state for the app.
    func reset() {
        isAuthenticationNeeded = isAuthenticationActive && hasItems
    }
}

@MainActor
private extension AppItemAuthContext {
    
    func update(isNeeded: Bool) {
        withAnimation {
            isAuthenticationNeeded = isNeeded
        }
    }
}

private extension AppItemAuthContext {

    var hasItems: Bool {
        stores.contains { $0.hasItems }
    }
}
#endif
