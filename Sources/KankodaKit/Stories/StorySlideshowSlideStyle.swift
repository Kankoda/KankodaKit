//
//  StorySlideshowSlideStyle.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be used with a ``StorySlideshowSlideStyle``.
 */
public struct StorySlideshowSlideStyleStyle {

    /**
     Create a story slideshow style.

     - Parameters:
       - titleFont: The font to use for the slide title, by default `.title`.
       - textFont: The font to use for the slide text, by default `.body`.
     */
    public init(
        titleFont: Font = .title,
        textFont: Font = .body
    ) {
        self.titleFont = titleFont
        self.textFont = textFont
    }

    /// The font to use for the slide title.
    public var titleFont: Font

    /// The font to use for the slide text.
    public var textFont: Font
}

public extension StorySlideshowSlideStyleStyle {

    /// This is the standard story slideshow style.
    static var standard = StorySlideshowSlideStyleStyle()
}
