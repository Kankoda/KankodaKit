//
//  AlternateAppIconListItem.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-07-06.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
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
        Image(image: ImageRepresentable(named: iconName) ?? ImageRepresentable())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: iconSize, height: iconSize)
            .shadow(.sticker)
            .overlay(alignment: .topLeading) {
                if isSelected {
                    Image.checkmarkSticker.padding(5)
                }
            }
    }
}

struct AlternateAppIconListItem_Previews: PreviewProvider {
    
    static var previews: some View {
        HStack {
            AlternateAppIconListItem(
                iconName: "Icon-Standard",
                iconSize: 120,
                isSelected: true
            ).background(Color.red)
            
            AlternateAppIconListItem(
                iconName: "Icon-Standard",
                isSelected: true
            )
            .background(Color.red)
            .frame(width: 100)
            
            Spacer()
        }
    }
}
