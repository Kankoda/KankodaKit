//
//  TestAppItem.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import CoreTransferable
import KankodaKit
import UniformTypeIdentifiers

struct TestAppItem: AppItem {
    
    init(
        id: UUID = .init(),
        name: String = "",
        sortOrder: Int = 0
    ) {
        self.id = id
        self.name = name
        self.sortOrder = sortOrder
    }
    
    let id: UUID
    var name: String
    var sortOrder: Int
    
    var formData: TestFormData { .init(self) }
    
    func update(with data: TestFormData) {}
    
    static let typeName = "TestItem"
    static let typePluralName = "TestItems"
    static var preview: Self { .placeholderItem() }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation<TestAppItem, JSONEncoder, JSONDecoder>(contentType: .testItem)
    }
    
    static func placeholderItem() -> TestAppItem {
        .init(id: UUID())
    }
    
    class TestFormData: AppItemFormData {
        
        required init(_ item: TestAppItem) {}
        
        var hasInformation: Bool = false
    }
}

class TestAppItemContext: AppItemContext {

    public init(items: [TestAppItem] = []) {
        self.items = items
    }
    
    @Published
    public var items: [TestAppItem]
}


extension UTType {

    static let testItem = UTType(exportedAs: "com.kankoda.test.item")
}
