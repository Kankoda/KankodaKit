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
    
    public init(appInfo info: AppInfo) {
        self.appInfo = info
        self.app =  URL(string: info.appUrlScheme)
        self.appStore = URL(string: "https://itunes.apple.com/app/id\(info.appStoreId)")
        self.contactEmail = URL(string: "mailto:\(info.contactEmail)")
        self.privacyPolicy = URL(string: "\(info.privacyUrl)")
        self.termsAndConditions = URL(string: info.termsUrl)
        self.website = URL(string: info.websiteUrl)
    }
    
    private let appInfo: AppInfo
    
    public let app: URL?
    public let appStore: URL?
    public let contactEmail: URL?
    public let privacyPolicy: URL?
    public let termsAndConditions: URL?
    public let website: URL?
    
    public var contactEmailBugReport: URL? {
        contactEmail(subject: "\(appInfo.appName) Bug Report")
    }
    
    public var contactEmailFeatureRequest: URL? {
        contactEmail(subject: "\(appInfo.appName) Feature Request")
    }
    
    public var contactEmailFeedback: URL? {
        contactEmail(subject: "\(appInfo.appName) Feedback")
    }
    
    public func contactEmail(subject: String) -> URL? {
        contactEmail?.appending(queryItems: [.init(name: "subject", value: subject)])
    }
}
