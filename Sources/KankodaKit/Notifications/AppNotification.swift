//
//  AppNotification.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-23.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI
import SystemNotification

/**
 This type can be used to specify app-specific notifications.
 
 You can create app-specific notifications like this:
 
 ```swift
 extension AppNotification {
 
     static let themeCopied = Self(
         .init(
             icon: .copy,
             title: L10n.SystemNotification.ThemeCopied.title,
             text: L10n.SystemNotification.ThemeAdded.message
         )
     )
 }
 ```
 
 You can then present the notification with the same context
 as you present any other notifications:
 
 ```swift
 context.present(.themeCopied)
 ```
 
 For custom notifications, use `SystemNotification` directly
 or create other notification types in this library.
 */
public struct AppNotification {
    
    public init(_ message: SystemNotificationMessage<Image>) {
        self.view = message
    }
    
    public let view: SystemNotificationMessage<Image>
}

public extension SystemNotificationContext {

    /// Present an app notification with an optional delay.
    func present(
        _ notification: AppNotification,
        withDelay delay: TimeInterval = 0.5
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.present(content: notification.view)
        }
    }
}
