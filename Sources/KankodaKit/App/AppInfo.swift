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
        contactEmail: String,
        privacyUrl: String,
        termsUrl: String = "https://apple.com/legal/internet-services/itunes/dev/stdeula/",
        websiteUrl: String
    ) {
        self.appName = appName
        self.appBundleIdentifier = appBundleIdentifier
        self.appStoreId = appStoreId
        self.appGroupId = appGroupId ?? "group.\(appBundleIdentifier)"
        self.appStoragePrefix = appStoragePrefix ?? "\(appBundleIdentifier).data"
        self.contactEmail = contactEmail
        self.privacyUrl = privacyUrl
        self.termsUrl = termsUrl
        self.websiteUrl = websiteUrl
    }
    
    public let appName: String
    public let appBundleIdentifier: String
    public let appStoreId: Int
    public let appGroupId: String
    public let appStoragePrefix: String
    public let contactEmail: String
    public let privacyUrl: String
    public let termsUrl: String
    public let websiteUrl: String
}
