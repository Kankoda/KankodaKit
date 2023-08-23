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
 This type can be used to specify app-specific notifications
 that use `SystemNotificationMessage` with plain image icons.
 
 Since this struct is non-generic, it works much better than
 the `SystemNotification` views, when it comes to extensions.
 
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
 
 For custom notification content views, use the notification
 library directly or create other notification types in this
 library.
 */
public struct AppNotification {
    
    init(_ message: SystemNotificationMessage<Image>) {
        self.message = message
    }
    
    let message: SystemNotificationMessage<Image>
}
