//
//  AlternateIconContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-07-06.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import Foundation
import SwiftUI

/**
 This class can be used to get and set an alternate app icon.
 
 TODO: Rename to AlternateAppIconContext + for all functions
 and properties, app in name.
 */
public class AlternateIconContext: ObservableObject {
    
    public init() {
        sync()
    }
    
    @Published
    public var alternateAppIconName: String?
}

public extension AlternateIconContext {
    
    /// Whether or not an alternate icon is set.
    var hasAlternateIcon: Bool {
        alternateAppIconName != nil
    }
    
    /// Check if a certain icon name is currently selected.
    func isCurrentAlternateIcon(_ name: String) -> Bool {
        name == alternateAppIconName
    }
    
    /// Reset the alternate app icon name.
    func resetAlternateIcon() {
        alternateAppIconName = nil
    }
    
    /// Set the alternate app icon name to use.
    func setAlternateIcon(_ name: String) {
        UIApplication.shared.setAlternateIconName(name) { (error) in
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

private extension AlternateIconContext {
    
    func sync() {
        alternateAppIconName = UIApplication.shared.alternateIconName
    }
}
#endif
