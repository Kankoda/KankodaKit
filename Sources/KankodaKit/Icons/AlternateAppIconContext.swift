//
//  AlternateAppIconContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-07-06.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

#if os(iOS)
import Foundation
import SwiftUI

/**
 This class can be used to get and set an alternate app icon.
 */
public class AlternateAppIconContext: ObservableObject {
    
    public init() {
        sync()
    }
    
    @Published
    public var alternateAppIconName: String?
}

public extension AlternateAppIconContext {
    
    /// Whether or not an alternate icon is set.
    var hasAlternateAppIcon: Bool {
        alternateAppIconName != nil
    }
    
    /// Check if a certain icon name is currently selected.
    func isCurrentAlternateAppIcon(_ iconName: String) -> Bool {
        iconName == alternateAppIconName
    }
    
    /// Reset the alternate app icon name.
    func resetAlternateIcon() {
        alternateAppIconName = nil
    }
    
    /// Set the alternate app icon name to use.
    func setAlternateIcon(_ newIconName: String) {
        UIApplication.shared.setAlternateIconName(newIconName) { (error) in
            if let error = error {
                print("Failed request to update the app’s icon: \(error)")
            } else {
                withAnimation {
                    self.sync()
                }
            }
        }
    }
}

private extension AlternateAppIconContext {
    
    func sync() {
        alternateAppIconName = UIApplication.shared.alternateIconName
    }
}
#endif
