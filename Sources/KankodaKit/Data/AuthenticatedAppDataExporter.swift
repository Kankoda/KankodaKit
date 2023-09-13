//
//  AuthenticatedAppItemDataExporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-07-03.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import LocalAuthentication

/**
 This exporter performs local authentication before it calls
 the provided `baseExporter` to perform the exporting.
 */
public class AuthenticatedAppDataExporter: AppDataExporter {

    /**
     Create an authenticated exporter.

     - Parameters:
       - baseExporter: The base exporter to use.
       - authReason: The authentication reason to display to the user.
     */
    public init(
        baseExporter: any AppDataExporter,
        authPolicy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics,
        authReason: String
    ) {
        self.exporter = baseExporter
        self.authPolicy = authPolicy
        self.authReason = authReason
    }
    
    public enum AuthError: Error {
        case userAuthenticationFailed
    }

    private let exporter: any AppDataExporter
    private let authPolicy: LAPolicy
    private let authReason: String

    public func generateExportFile<DataType: AppData>(
        for data: DataType
    ) async throws -> URL {
        let url = try await exporter.generateExportFile(for: data)
        guard try await performAuthentication() else { throw AuthError.userAuthenticationFailed }
        return url
    }
    
    public func generateQrCodeDataString<DataType: AppData>(
        for data: DataType
    ) async throws -> String {
        guard try await performAuthentication() else { throw AuthError.userAuthenticationFailed }
        return try await exporter.generateQrCodeDataString(for: data)
    }
}

private extension AuthenticatedAppDataExporter {
    
    func performAuthentication() async throws -> Bool {
        try await LAContext().evaluatePolicy(
            authPolicy,
            localizedReason: authReason
        )
    }
}
