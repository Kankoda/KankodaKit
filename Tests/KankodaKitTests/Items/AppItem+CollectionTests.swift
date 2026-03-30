//
//  AppItem+CollectionTests.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import KankodaKit
import XCTest

final class AppItem_CollectionTests: XCTestCase {

    let orderedItems: [TestAppItem] = {
        var item1 = TestAppItem(name: "card1", sortOrder: 2)
        var item2 = TestAppItem(name: "card2", sortOrder: 1)
        var item3 = TestAppItem(name: "card3", sortOrder: 0)
        return [item1, item2, item3]
    }()

    func test_itemsAtIndexSetReturnsValidItems() {
        let items: [TestAppItem] = [.preview, .preview, .preview, .preview, .preview]
        let result = items.items(at: IndexSet([1, 0, 3]))

        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0].id, items[0].id)
        XCTAssertEqual(result[1].id, items[1].id)
        XCTAssertEqual(result[2].id, items[3].id)
    }

    func test_itemsAtIndexSetFiltersOutInvalidIndices() {
        let items: [TestAppItem] = [.preview, .preview, .preview, .preview, .preview]
        let result = items.items(at: IndexSet([0, 30, 1]))

        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].id, items[0].id)
        XCTAssertEqual(result[1].id, items[1].id)
    }
}
