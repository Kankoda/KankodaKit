//
//  BiometricAuthenticationContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2026-08-11.
//  Copyright © 2026 Kankoda. All rights reserved.
//

#if os(macOS) || os(iOS) || os(watchOS) || os(visionOS)
import LocalAuthentication
import SwiftUI

/// This type can be used to manage biometric authentication
/// for an app that should be .
///
/// Authentication is disabled when biometric authentication
/// is not supported, or if it's disabled it in Settings.
@Observable
public class BiometricAuthenticationContext {

    /// Create an app item authentication context.
    ///
    /// The `isEnabled` parameter can be used as a main kill
    /// switch for the entire authentication, e.g. if an app
    /// provides authentication as a setting. Authentication
    /// can still be unavailable even if `isEnabled` it true,
    /// for instance in previews, and on devices that lack a
    /// biometric authentication method.
    ///
    /// - Parameters:
    ///  - isEnabled: Whether authentication is enabled.
    ///  - policy: The local authentication policy to use.
    ///  - isAuthenticationNeeded: A resolver that checks if authentication is needed.
    @MainActor
    public init(
        isEnabled: Bool = true,
        policy: LAPolicy? = nil,
        isAuthenticationNeeded isNeeded: @escaping @MainActor () -> Bool
    ) {
        self.authPolicy = policy ?? Self.defaultPolicy
        self.isAuthenticationEnabled = isEnabled
        self.isAuthenticationNeeded = isEnabled
        self.isAuthenticationNeededResolver = isNeeded
        self.reset()
    }

    private static var defaultPolicy: LAPolicy {
        #if os(iOS) || os(macOS) || os(visionOS)
        LAPolicy.deviceOwnerAuthenticationWithBiometrics
        #else
        LAPolicy.deviceOwnerAuthenticationWithWristDetection
        #endif
    }

    private let authPolicy: LAPolicy
    private let defaults = UserDefaults.standard
    private let isAuthenticationNeededResolver: @MainActor () -> Bool

    /// Whether authentication is needed.
    public var isAuthenticationNeeded: Bool

    /// Whether authentication is enabled by the user.
    public var isAuthenticationEnabled: Bool
}

public extension BiometricAuthenticationContext {

    /// Whether or not authentication is active for the app.
    var isAuthenticationActive: Bool {
        guard isAuthenticationEnabled else { return false }
        if ProcessInfo.isSwiftUIPreview { return false }
        return LAContext().canEvaluatePolicy(authPolicy, error: nil)
    }
}

@MainActor
public extension BiometricAuthenticationContext {
    
    /// Authenticate the user.
    func authenticateUser(
        reason: String
    ) async throws -> Bool {
        try await LAContext().evaluatePolicy(authPolicy, localizedReason: reason)
    }

    /// Reset authentication state for the app.
    func reset() {
        isAuthenticationNeeded = isAuthenticationActive && isAuthenticationNeededResolver()
    }
    
    /// Try to authenticate the user, provided that it's needed.
    func tryAuthenticateUser(reason: String) {
        guard isAuthenticationNeeded else { return }
        Task {
            let success = (try? await authenticateUser(reason: reason)) ?? true
            update(isNeeded: !success)
        }
    }
}

@MainActor
private extension BiometricAuthenticationContext {

    func update(isNeeded: Bool) {
        withAnimation {
            isAuthenticationNeeded = isNeeded
        }
    }
}
#endif
