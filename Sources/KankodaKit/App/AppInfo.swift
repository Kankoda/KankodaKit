//
//  AppInfo.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-17.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct provides app-specific information.
 */
public struct AppInfo {
 
    public init(
        appName: String,
        appBundleIdentifier: String,
        appStoreId: Int,
        appGroupId: String? = nil,
        appStoragePrefix: String? = nil,
        appUrlScheme: String = "",
        contactEmail: String,
        websiteUrl: String,
        privacyUrl: String,
        termsUrl: String = "https://apple.com/legal/internet-services/itunes/dev/stdeula/"
    ) {
        self.appName = appName
        self.appBundleIdentifier = appBundleIdentifier
        self.appStoreId = appStoreId
        self.appGroupId = appGroupId ?? "group.\(appBundleIdentifier)"
        self.appStoragePrefix = appStoragePrefix ?? "\(appBundleIdentifier).data"
        self.appUrlScheme = appUrlScheme
        self.contactEmail = contactEmail
        self.websiteUrl = websiteUrl
        self.privacyUrl = privacyUrl
        self.termsUrl = termsUrl
    }
    
    public let appName: String
    public let appBundleIdentifier: String
    public let appStoreId: Int
    public let appGroupId: String
    public let appStoragePrefix: String
    public let appUrlScheme: String
    public let contactEmail: String
    public let websiteUrl: String
    public let privacyUrl: String
    public let termsUrl: String
    
    public var urls: AppUrls { .init(appInfo: self) }
}

public extension AppInfo {
    
    static var preview = Self.init(
        appName: "Preview",
        appBundleIdentifier: "com.kankoda.app",
        appStoreId: 123456,
        contactEmail: "info@kankoda.com",
        websiteUrl: "https://kankoda.com",
        privacyUrl: "https://kankoda.com/privacy"
    )
}
