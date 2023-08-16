//
//  AppUrls.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-17.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct provides app-specific URLs.
 */
public struct AppUrls {
    
    public init(appInfo: AppInfo) {
        self.appInfo = appInfo
        self.appStore = URL(string: "https://itunes.apple.com/app/id\(appInfo.appStoreId)")
        self.contactEmail = URL(string: "mailto:\(appInfo.contactEmail)")
        self.privacyPolicy = URL(string: "\(appInfo.privacyUrl)")
        self.termsAndConditions = URL(string: appInfo.termsUrl)
        self.website = URL(string: appInfo.websiteUrl)
    }
    
    private let appInfo: AppInfo
    
    public let appStore: URL?
    public let contactEmail: URL?
    public let privacyPolicy: URL?
    public let termsAndConditions: URL?
    public let website: URL?
    
    public func contactEmail(subject: String) -> URL? {
        contactEmail?.appending(queryItems: [.init(name: "subject", value: subject)])
    }
}
