//
//  AppItem+Image.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-21.
//  Copyright © 2022-2026 Kankoda. All rights reserved.
//

import Foundation

/// This protocol represents a physical item with image data.
public protocol ImageItem {}

@MainActor
public extension ImageItem {
    
    /// Use a shared image cache.
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

/// This type can be used to cache images.
public class ImageCache {
    
    /// A shared cache.
    @MainActor public static let shared = ImageCache()

    /// The cache dictionary that is used to store images.
    public var cache = [String: ImageRepresentable]()

    /// Store an image into the cache.
    public func cache(image: ImageRepresentable, for key: String) {
        cache[key] = image
    }
    
    /// Try to get an image from the cache.
    public func cachedImage(for key: String) -> ImageRepresentable? {
        cache[key]
    }

    /// Remove the cached image for a certain key.
    public func clearCache(for key: String) {
        cache[key] = nil
    }
}
