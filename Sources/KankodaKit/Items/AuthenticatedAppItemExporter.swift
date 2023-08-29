//
//  AuthenticatedAppItemExporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-07-03.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import LocalAuthentication

/**
 This data exporter wraps another exporter and adds an extra
 authentication step before exporting data.
 */
public class AuthenticatedAppItemExporter: AppItemExporter {

    /**
     Create an authenticated data exporter.

     - Parameters:
       - baseExporter: The base exporter to use.
       - authReason: The authentication reason to display to the user.
     */
    public init(
        baseExporter: AppItemExporter,
        authPolicy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics,
        authReason: String
    ) {
        self.baseExporter = baseExporter
        self.authContext = LAContext()
        self.authPolicy = authPolicy
        self.authReason = authReason
    }

    private let baseExporter: AppItemExporter
    private let authContext: LAContext
    private let authPolicy: LAPolicy
    private let authReason: String

    public func generateExportFile(for data: any AppItemExportData) async throws -> URL {
        let url = try await baseExporter.generateExportFile(for: data)
        let result = try await authContext.evaluatePolicy(authPolicy, localizedReason: authReason)
        guard result else { return url }
        return url
    }
}
