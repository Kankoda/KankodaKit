//
//  AppItemAuthContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-06-30.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import LocalAuthentication
import SwiftUI

/**
 This class can manage authentication for an app that stores
 sensitive `AppItem` data.
 
 Authentication will be disabled is biometric authentication
 is not supported by the device, or if the user has disabled
 it in System Settings.
 */
public class AppItemAuthContext: ObservableObject {
    
    public init(
        policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics,
        stores: [any AppItemStore]
    ) {
        self.authPolicy = policy
        self.stores = stores
        self.isAuthenticationNeeded = true
        resetAuthentication()
    }
    
    private let authPolicy: LAPolicy
    private let stores: [any AppItemStore]
    
    /// Whether or not authentication is needed to use the app.
    @Published
    public var isAuthenticationNeeded: Bool
    
    /// Whether or not authentication is enabled for the app.
    public var isAuthenticationEnabled: Bool {
        LAContext().canEvaluatePolicy(authPolicy, error: nil)
    }
    
    /// Try to authenticate the user, provided that it's needed.
    public func authenticateUser(reason: String) {
        guard isAuthenticationNeeded else { return }
        Task {
            let result = try await LAContext().evaluatePolicy(authPolicy, localizedReason: reason)
            await updateState(isAuthenticationNeeded: !result)
        }
    }
    
    /// Reset authentication for the app.
    public func resetAuthentication() {
        isAuthenticationNeeded = isAuthenticationEnabled && hasItems
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
