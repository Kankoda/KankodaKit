//
//  AppItem.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import CoreTransferable
import Foundation

/**
 This protocol describes an item that can be stored and used
 in an app, such as wallet items in Wally.
 */
public protocol AppItem: Codable, Equatable, Identifiable, Transferable {
    
    /// The unique item id.
    var id: UUID { get }
    
    /// The form data type used to edit this type.
    associatedtype FormData: AppItemFormData
    
    /// The type name, e.g. "Card".
    static var typeName: String { get }
    
    /// The type's plural name, e.g. "Cards".
    static var typePluralName: String { get }
    
    /// Create an empty placeholder item.
    static func placeholderItem() -> Self
    
    /// Update the item with the provided form data.
    mutating func update(with data: FormData)
}

/**
 This protocol describes observable data for an ``AppItem``.
 */
public protocol AppItemFormData: ObservableObject {

    /// The item type that is associated with the form data.
    associatedtype Item: AppItem

    /// Create form data from a master item.
    init(_ item: Item)

    /// Whether or the form data contains any information.
    var hasInformation: Bool { get }
}

public extension AppItemFormData {

    func hasValue(for string: String) -> Bool {
        !string.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func hasValue(forEither strings: [String]) -> Bool {
        strings.contains { hasValue(for: $0) }
    }
}

public extension Array where Element: AppItem {

    /// Get items at a certain index set in the array.
    func items(at indexSet: IndexSet) -> [Element] {
        let indices = indexSet.filter { $0 < count }
        return indices.compactMap { self[$0] }
    }
}
