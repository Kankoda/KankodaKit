//
//  Stories+Slide.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI

public extension Stories {
    
    /**
     This is a standard story slide, which has a title, text,
     image, as well as an optional primary button.
     */
    struct Slide: View {
        
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
            style: SlideStyle = .standard
        ) {
            self.title = title
            self.text = text
            self.image = image
            self.style = style
        }
        
        private let title: String
        private let text: String
        private let image: Image
        private let style: SlideStyle
        
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
}

private extension Stories.Slide {
    
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

struct Stories_Slide_Previews: PreviewProvider {
    
    static var previews: some View {
        Stories.Slide(
            title: "Manage your loans – all in one place",
            text: "Track, pay, and refinance your loans so you can be in control of your debt. ",
            image: Image(systemName: "rectangle.and.pencil.and.ellipsis")
        )
        .padding()
    }
}
#endif
