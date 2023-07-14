//
//  StorySlide.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI

/**
 This is a standard story slideshow slide with a title, text,
 image and an optional primary button.
 */
public struct StorySlide: View {
    
    /**
     Create a story slideshow slide view.
     
     - Parameters:
       - title: The slide title.
       - text: The slide text.
       - image: The background image of the slide.
       - style: The style to use, by default `.standard`.
     **/
    public init(
        title: String,
        text: String,
        image: Image,
        style: StorySlideStyle = .standard
    ) {
        self.title = title
        self.text = text
        self.image = image
        self.style = style
    }
    
    private let title: String
    private let text: String
    private let image: Image
    private let style: StorySlideStyle
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            backgroundImage
            
            VStack(spacing: 16) {
                Text(title)
                    .font(style.titleFont)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(text)
                    .font(style.textFont)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
        }
    }
}

private extension StorySlide {
    
    var backgroundImage: some View {
        backgroundImageView
            .scaleEffect(style.imageScaleFactor, anchor: style.imageAlignment)
    }
    
    var backgroundImageView: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}


// MARK: - Style

/**
 This style can be used to style a ``StorySlide`` view.
 */
public struct StorySlideStyle {

    /**
     Create a story slide style.

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

public extension StorySlideStyle {

    /// This is a standard story slideshow style.
    static var standard = Self.init()
}


// MARK: - Preview

struct Stories_Slide_Previews: PreviewProvider {
    
    static var previews: some View {
        StorySlide(
            title: "Manage your loans – all in one place",
            text: "Track, pay, and refinance your loans so you can be in control of your debt. ",
            image: Image(systemName: "rectangle.and.pencil.and.ellipsis")
        )
        .padding()
    }
}
#endif
