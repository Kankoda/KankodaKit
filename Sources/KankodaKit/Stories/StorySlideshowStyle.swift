//
//  StorySlideshow.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be used to style ``StorySlideshow`` views.
 */
public struct StorySlideshowStyle {

    /**
     Create a story slideshow style.

     - Parameters:
       - progressBarBackgroundColor: The color to use below the progress bar, by default `.primary`.
       - progressBarForegroundColor: The color to use for the progress bar, by default `.primary` with opacity.
       - progressBarHeight: The height of the progress bar, by default `3.0`.
     */
    public init(
        progressBarBackgroundColor: Color = .primary.opacity(0.2),
        progressBarForegroundColor: Color = .primary,
        progressBarHeight: Double = 3.0
    ) {
        self.progressBarBackgroundColor = progressBarBackgroundColor
        self.progressBarForegroundColor = progressBarForegroundColor
        self.progressBarHeight = progressBarHeight
    }

    /// The color to use below the progress bar.
    public var progressBarBackgroundColor: Color

    /// The color to use for the progress bar.
    public var progressBarForegroundColor: Color

    /// The height of the progress bar.
    public var progressBarHeight: Double
}

public extension StorySlideshowStyle {

    /// This is the standard story slideshow style.
    static var standard = StorySlideshowStyle()
}
