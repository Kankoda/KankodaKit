//
//  AppItem+Image.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-21.
//  Copyright © 2022-2024 Kankoda. All rights reserved.
//

import Foundation
import SwiftUIKit

/// This protocol represents a physical item with image data.
public protocol ImageItem {}

public extension ImageItem {

    /// The image cache to use for caching images.
    var imageCache: ImageCache { .shared }

    /// Get an image either from the cache or the raw `data`.
    func image(withKey key: String, data: @escaping () -> Data?) -> ImageRepresentable? {
        if let image = imageCache.cachedImage(for: key) { return image }
        guard let data = data() else { return nil }
        guard let image = ImageRepresentable(data: data) else { return nil }
        imageCache.cache(image: image, for: key)
        return image
    }
}
