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
        self.privacyPolicy = URL(string: "\(info.privacyUrl)")
        self.termsAndConditions = URL(string: info.termsUrl)
        self.website = URL(string: info.websiteUrl)
    }
    
    private let appName: String
    
    public let app: URL?
    public let appStore: URL?
    public let contactEmail: URL?
    public let privacyPolicy: URL?
    public let termsAndConditions: URL?
    public let website: URL?
    
    public var contactEmailBugReport: URL? {
        contactEmail(subject: "\(appName) Bug Report")
    }
    
    public var contactEmailFeatureRequest: URL? {
        contactEmail(subject: "\(appName) Feature Request")
    }
    
    public var contactEmailFeedback: URL? {
        contactEmail(subject: "\(appName) Feedback")
    }
    
    public func contactEmail(subject: String) -> URL? {
        contactEmail?.appending(queryItems: [.init(name: "subject", value: subject)])
    }
}
