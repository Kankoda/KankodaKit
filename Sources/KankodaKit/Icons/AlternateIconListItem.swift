//
//  AlternateIconListItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-07-06.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used as a list item when listing alternate
 app icons.
 */
public struct AlternateIconListItem: View {
    
    /**
     Create an alternate icon list item.
     
     - Parameters:
       - iconName: The name of the icon.
       - iconSize: The size of the icon.
       - isSelected: Whether or not the icon is selected.
     */
    public init(
        iconName: String,
        iconSize: Double = 120,
        isSelected: Bool = false
    ) {
        self.iconName = iconName
        self.iconSize = iconSize
        self.isSelected = isSelected
    }
    
    private let iconName: String
    private let iconSize: Double
    private let isSelected: Bool
    
    public var body: some View {
        Image(uiImage: UIImage(named: iconName) ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: iconSize, height: iconSize)
            .cornerRadius(0.225 * iconSize)
            .shadow(.sticker)
            .overlay(alignment: .topLeading) {
                if isSelected {
                    Image.checkmarkSticker.padding(5)
                }
            }
    }
}

struct AlternateIconListItem_Previews: PreviewProvider {
    
    static var previews: some View {
        AlternateIconListItem(
            iconName: "Icon-Standard",
            isSelected: true
        )
    }
}
