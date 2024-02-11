//
//  Image+Kankoda.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit

public extension Image {

    static let adminModeDisabled = symbol("shield.slash")
    static let adminModeEnabled = symbol("bolt.shield")
    static let appStore = symbol("apple.logo")
    static let bookmark = symbol("bookmark")
    static let bug = symbol("ladybug")
    static let checkmark = symbol("checkmark")
    static let copy = symbol("doc.on.doc")
    static let delete = symbol("trash")
    static let dragHandle = symbol("line.3.horizontal")
    static let edit = symbol("square.and.pencil")
    static let email = symbol("envelope")
    static let exclamation = symbol("exclamationmark")
    static let featureRequest = symbol("gift")
    static let feedback = symbol("lightbulb")
    static let globe = symbol("globe")
    static let hint = symbol("lightbulb")
    static let info = symbol("info.circle")
    static let lightbulb = symbol("lightbulb")
    static let menubar = symbol("menubar.rectangle")
    static let navigationArrow = symbol("chevron.right")
    static let plus = symbol("plus")
    static let premium = symbol("crown")
    static let privacy = symbol("checkmark.shield")
    static let qrCode = symbol("qrcode")
    static let reset = symbol("xmark.circle")
    static let review = symbol("star")
    static let safari = symbol("safari")
    static let settings = symbol("gearshape")
    static let share = symbol("square.and.arrow.up")
    static let star = symbol("star")
    static let termsAndConditions = symbol("pencil.circle")
    static let trash = symbol("trash")
    static let tutorial = lightbulb

    static let favorite = star

    static var checkmarkSticker: some View {
        Image.checkmark
            .sticker(.green, .white, shadow: false)
            .background(Circle().fill(.white).shadow(.badge))
            .font(.largeTitle)
    }

    static var favoriteSticker: some View {
        Image.favorite
            .sticker(.white, .yellow)
            .font(.largeTitle)
    }

    static func favorite(isActive: Bool) -> some View {
        Image.bookmark
            .symbolVariant(isActive ? .fill : .none)
            .foregroundColor(isActive ? .favorite : nil)
            .contentShape(Rectangle())
    }

    func sticker<Badge: ShapeStyle>(
        _ badgeColor: Badge,
        _ iconColor: Color,
        shadow: Bool = true
    ) -> some View {
        ZStack {
            stickerImage
                .foregroundStyle(.clear, badgeColor)
                .shadow(shadow ? .badge : .none)
            stickerImage
                .foregroundStyle(iconColor, .clear)
        }
    }

    var stickerImage: some View {
        self
           .symbolVariant(.fill)
           .symbolVariant(.circle)
           .symbolRenderingMode(.palette)
    }
}

#Preview {

    var previewIcons: [Image] {
        [
            .adminModeDisabled,
            .adminModeEnabled,
            .appStore,
            .bookmark,
            .bug,
            .checkmark,
            .copy,
            .delete,
            .dragHandle,
            .edit,
            .email,
            .exclamation,
            .featureRequest,
            .globe,
            .hint,
            .lightbulb,
            .menubar,
            .navigationArrow,
            .plus,
            .premium,
            .privacy,
            .qrCode,
            .reset,
            .review,
            .share,
            .termsAndConditions,
            .trash,
            .tutorial
        ]
    }

    return List {
        Section("Preview.Symbolic") {
            ForEach(Array(previewIcons.enumerated()), id: \.offset) {
                $0.element
            }
        }
        Section("Preview.Semantic") {
            Image.checkmarkSticker
            Image.favoriteSticker
            Image.favorite(isActive: false)
            Image.favorite(isActive: true)
        }
    }
}
