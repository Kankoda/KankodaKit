//
//  AppItemAuthContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-06-30.
//  Copyright © 2022-2025 Kankoda. All rights reserved.
//

#if os(macOS) || os(iOS)
import LocalAuthentication
import SwiftUI
import SwiftUIKit

/// This class manages authentication for an app that stores
/// sensitive ``AppItem`` data.
///
/// Authentication is disabled when biometric authentication
/// is not supported, or if it's disabled it in Settings.
@Observable
public class AppItemAuthContext {
    
    public init(
        isEnabled: Bool = true,
        policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics,
        stores: [any AppItemStore]
    ) {
        self.authPolicy = policy
        self.stores = stores
        self.isAuthenticationEnabled = isEnabled
        self.isAuthenticationNeeded = isEnabled
        resetAuthentication()
    }
    
    private let authPolicy: LAPolicy
    private let stores: [any AppItemStore]
    private let defaults = UserDefaults.standard
    
    /// Whether or not authentication is needed.
    public var isAuthenticationNeeded: Bool
    
    /// Whether or not authentication is enabled by user.
    public var isAuthenticationEnabled: Bool
}

public extension AppItemAuthContext {
    
    /// Whether or not authentication is active for the app.
    var isAuthenticationActive: Bool {
        guard isAuthenticationEnabled else { return false }
        if ProcessInfo.isSwiftUIPreview { return false }
        return LAContext().canEvaluatePolicy(authPolicy, error: nil)
    }
    
    /// Try to authenticate the user, provided that it's needed.
    func authenticateUser(reason: String) {
        guard isAuthenticationNeeded else { return }
        Task {
            let result = try await LAContext().evaluatePolicy(authPolicy, localizedReason: reason)
            await updateState(isAuthenticationNeeded: !result)
        }
    }
    
    /// Reset authentication for the app.
    func resetAuthentication() {
        isAuthenticationNeeded = isAuthenticationActive && hasItems
    }
}

@MainActor
private extension AppItemAuthContext {
    
    func updateState(
        isAuthenticationNeeded: Bool
    ) {
        self.isAuthenticationNeeded = isAuthenticationNeeded
    }
}

private extension AppItemAuthContext {

    var hasItems: Bool {
        stores.contains { $0.hasItems }
    }
}
#endif
