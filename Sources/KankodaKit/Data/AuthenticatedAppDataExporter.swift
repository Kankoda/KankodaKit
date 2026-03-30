//
//  AuthenticatedAppDataExporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-07-03.
//  Copyright © 2022-2026 Kankoda. All rights reserved.
//

#if os(macOS) || os(iOS)
import Foundation
import LocalAuthentication

/// This exporter performs local authentication before performing an export.
public class AuthenticatedAppDataExporter: AppDataExporter {
    
    /// Create an authenticated exporter.
    /// 
    /// - Parameters:
    ///   - baseExporter: The base exporter to use.
    ///   - authReason: The authentication reason to display to the user.
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
}

public extension AuthenticatedAppDataExporter {

    func generateExportFile<DataType: AppData>(
        for data: DataType
    ) async throws -> URL {
        guard try await performAuthentication() else {
            throw AuthError.userAuthenticationFailed
        }
        return try await exporter.generateExportFile(for: data)
    }
    
    func generateQrCodeDataString<DataType: AppData>(
        for data: DataType
    ) async throws -> String {
        guard try await performAuthentication() else {
            throw AuthError.userAuthenticationFailed
        }
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
#endif
