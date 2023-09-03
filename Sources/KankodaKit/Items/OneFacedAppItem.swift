//
//  OneFacedAppItem.swift
//  WallyKit
//
//  Created by Daniel Saidi on 2022-08-21.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUIKit

/**
 This protocol specializes the ``AppItem`` protocol for item
 types that represent physical things with a single face.
 */
public protocol OneFacedAppItem: AppItem {

    /// The items's image data.
    var imageData: Data { get set }
}

public extension OneFacedAppItem {

    /// Whether or not the item has an image.
    var hasImage: Bool {
        image != nil
    }
    
    /// Get the item image from the cache or its raw data.
    var image: ImageRepresentable? {
        image(withKey: imageCacheKey) {
            imageData
        }
    }
    
    /// Set the item image and reset the image cache.
    mutating func setImage(_ image: ImageRepresentable) {
        guard let data = image.jpegData() else { return }
        imageData = data
        imageCache.clearCache(for: imageCacheKey)
    }
}

private extension OneFacedAppItem {

    /// The cache key to use for the item.
    var imageCacheKey: String {
        id.uuidString
    }
}
