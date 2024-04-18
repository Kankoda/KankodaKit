//
//  AppInfo.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-17.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import Foundation

/// This struct defines app-specific information.
public struct AppInfo {
 
    public init(
        appName: String,
        appBundleIdentifier: String,
        appStoreId: Int,
        appGroupId: String? = nil,
        appStoragePrefix: String? = nil,
        appUrlScheme: String = "",
        contactEmail: String,
        subscriptionGroupId: String = "",
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
        self.subscriptionGroupId = subscriptionGroupId
        
        self.websiteUrl = URL(string: websiteUrl)
        self.privacyUrl = URL(string: privacyUrl)
        self.termsUrl = URL(string: termsUrl)
        
        self.urls = .init()
        self.urls = .init(appInfo: self)
    }
    
    public let appName: String
    public let appBundleIdentifier: String
    public let appStoreId: Int
    public let appGroupId: String
    public let appStoragePrefix: String
    public let appUrlScheme: String
    public let contactEmail: String
    public let subscriptionGroupId: String
    
    let websiteUrl: URL?
    let privacyUrl: URL?
    let termsUrl: URL?
    
    public private(set) var urls: AppUrls
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
