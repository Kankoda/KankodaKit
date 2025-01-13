//
//  AppUrls.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-17.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
//

import Foundation

/// This struct defines app-specific URLs.
public struct AppUrls {
    
    init() {
        self.app = nil
        self.appName = ""
        self.appStore = nil
        self.contactEmail = nil
        self.privacyPolicy = nil
        self.termsAndConditions = nil
        self.website = nil
    }
    
    public init(appInfo info: AppInfo) {
        self.app =  URL(string: info.appUrlScheme)
        self.appName = info.appName
        self.appStore = URL(string: "https://itunes.apple.com/app/id\(info.appStoreId)")
        self.contactEmail = URL(string: "mailto:\(info.contactEmail)")
        self.privacyPolicy = info.privacyUrl
        self.termsAndConditions = info.termsUrl
        self.website = info.websiteUrl
    }
    
    private let appName: String
    
    public let app: URL?
    public let appStore: URL?
    public let contactEmail: URL?
    public let privacyPolicy: URL?
    public let termsAndConditions: URL?
    public let website: URL?
}

public extension AppUrls {
    
    var contactEmailBugReport: URL? {
        contactEmail(subject: "\(appName) Bug Report")
    }
    
    var contactEmailFeatureRequest: URL? {
        contactEmail(subject: "\(appName) Feature Request")
    }
    
    var contactEmailFeedback: URL? {
        contactEmail(subject: "\(appName) Feedback")
    }
    
    func contactEmail(subject: String) -> URL? {
        contactEmail?.appending(
            queryItems: [.init(name: "subject", value: subject)]
        )
    }
}
