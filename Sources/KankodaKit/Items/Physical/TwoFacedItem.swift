//
//  TwoFacedItem.swift
//  WallyKit
//
//  Created by Daniel Saidi on 2022-08-21.
//  Copyright © 2022-2025 Kankoda. All rights reserved.
//

import Foundation

/// This protocol represents an item with two faces.
public protocol TwoFacedItem: Identifiable, ImageItem where ID == UUID {

    /// The items's front image data.
    var frontImageData: Data { get set }

    /// The items's back image data.
    var backImageData: Data { get set }
}

@MainActor
public extension TwoFacedItem {
    
    /// Get the item front & back images from cache or data.
    var images: [ImageRepresentable] {
        [image(for: .front), image(for: .back)]
            .compactMap { $0 }
    }

    /// Whether or not the item has an image for a face.
    func hasImage(for face: ItemFace) -> Bool {
        image(for: face) != nil
    }

    /// Get a face image from the cache or its raw data.
    func image(for face: ItemFace) -> ImageRepresentable? {
        image(withKey: imageCacheKey(for: face)) {
            switch face {
            case .front: return frontImageData
            case .back: return backImageData
            }
        }
    }

    /// Set the image for a face and reset the image cache.
    mutating func setImage(_ image: ImageRepresentable, for face: ItemFace) {
        guard let data = image.jpegData() else { return }
        switch face {
        case .front:
            frontImageData = data
            clearImageCache(for: .front)
        case .back:
            backImageData = data
            clearImageCache(for: .back)
        }
    }
}

@MainActor
private extension TwoFacedItem {

    /// Clear the image cache for a certain item face.
    func clearImageCache(for face: ItemFace) {
        let key = imageCacheKey(for: face)
        imageCache.clearCache(for: key)
    }

    /// The cache key to use for a certain item face.
    func imageCacheKey(for face: ItemFace) -> String {
        "\(id.uuidString)_\(face.id)"
    }
}
