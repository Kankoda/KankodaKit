//
//  LocalizedTutorial+App.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-25.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import OnboardingKit

public extension LocalizedTutorial {
    
    /**
     This is a standard welcome tutorial.
     
     Implement this by adding strings to Localizable.strings:
     
     ```
     "tutorial.welcome.0.title" = "Welcome";
     "tutorial.welcome.0.text" = "Glad to have you here!";
     "tutorial.welcome.1.title" = "That's all for now";
     "tutorial.welcome.1.text" = "Have fun using this app!";
     ```
     
     This tutorial then automatically converts this to pages.
     */
    static let welcome = LocalizedTutorial(id: "welcome")
}
