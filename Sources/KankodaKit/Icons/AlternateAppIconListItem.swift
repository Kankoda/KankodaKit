//
//  AlternateAppIconListItem.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-07-06.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import SwiftUI
import SwiftUIKit

/**
 This view can be used as a list alternate app icons by name.
 */
public struct AlternateAppIconListItem: View {
    
    /**
     Create an alternate icon list item.
     
     - Parameters:
       - iconName: The name of the icon.
       - iconSize: The size of the icon, if any.
       - isSelected: Whether or not the icon is selected.
     */
    public init(
        iconName: String,
        iconSize: CGFloat? = nil,
        isSelected: Bool = false
    ) {
        self.iconName = iconName
        self.iconSize = iconSize
        self.isSelected = isSelected
    }
    
    private let iconName: String
    private let iconSize: CGFloat?
    private let isSelected: Bool
    
    public var body: some View {
        imageView
            .frame(width: iconSize, height: iconSize)
            .opacity(0)
            .overlay(overlay)
            .overlay(alignment: .topLeading) { checkmark }
    }
}

private extension AlternateAppIconListItem {
    
    @ViewBuilder
    var checkmark: some View {
        if isSelected {
            Image.checkmarkSticker.padding(5)
        }
    }
    
    var image: Image {
        if let image = ImageRepresentable(named: iconName) {
            return Image(image: image)
        } else {
            return Image(systemName: "squareshape.fill")
        }
    }
    
    var imageView: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var overlay: some View {
        GeometryReader { geo in
            imageView
                .cornerRadius(0.225 * geo.size.width)
                .shadow(.sticker)
        }
    }
}

#Preview {
    
    HStack {
        AlternateAppIconListItem(
            iconName: "Icon-Standard",
            iconSize: 120,
            isSelected: true
        )
        
        AlternateAppIconListItem(
            iconName: "Icon-Standard",
            isSelected: true
        )
        .frame(width: 100)
    }
}
