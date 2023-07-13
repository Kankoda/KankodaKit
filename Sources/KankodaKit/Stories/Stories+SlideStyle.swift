//
//  Stories+SlideStyle.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI

public extension Stories {
    
    /**
     This style can be used to style a story slideshow slide.
     */
    struct SlideStyle {

        /**
         Create a story slideshow style.

         - Parameters:
           - titleFont: The font to use for the slide title, by default `.title`.
           - textFont: The font to use for the slide text, by default `.body`.
           - imageScaleFactor: The scale factor to apply to the image, by default `1`.
           - imageAlignment: The alignment apply to the image, by default `.bottom`.
         */
        public init(
            titleFont: Font = .title,
            textFont: Font = .body,
            imageScaleFactor: Double = 1,
            imageAlignment: UnitPoint = .bottom
        ) {
            self.titleFont = titleFont
            self.textFont = textFont
            self.imageScaleFactor = imageScaleFactor
            self.imageAlignment = imageAlignment
        }

        /// The font to use for the slide title.
        public var titleFont: Font

        /// The font to use for the slide text.
        public var textFont: Font
        
        /// The scale factor to apply to the image.
        public var imageScaleFactor: Double
        
        /// The alignment apply to the image.
        public var imageAlignment: UnitPoint
    }
}

public extension Stories.SlideStyle {

    /// This is the standard story slideshow style.
    static var standard = Self.init()
}
#endif
