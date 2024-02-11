//
//  AppItemContextTests.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023 Kankoda. All rights reserved.
//

import KankodaKit
import XCTest

final class AppItemContextTests: XCTestCase {

    var context: TestAppItemContext!

    override func setUp() {
        context = TestAppItemContext(items: [])
    }

    func test_hasItems_returnsItemState() {
        context.items = []
        XCTAssertFalse(context.hasItems)
        context.items = [.preview]
        XCTAssertTrue(context.hasItems)
    }

    func test_hasMultipleItems_returnsItemState() {
        context.items = []
        XCTAssertFalse(context.hasMultipleItems)
        context.items = [.preview]
        XCTAssertFalse(context.hasMultipleItems)
        context.items = [.preview, .preview]
        XCTAssertTrue(context.hasMultipleItems)
    }

    func test_addItem_canAddSingleItem() {
        let item = TestAppItem()
        context.add(item)
        XCTAssertEqual(context.items.count, 1)
        XCTAssertEqual(context.items[0].id, item.id)
    }

    func test_addItem_canReplaceExistingItems() {
        let item1 = TestAppItem(name: "Item 1")
        var item2 = item1
        item2.name = "Item 2"
        context.add(item1)
        XCTAssertEqual(context.items.count, 1)
        XCTAssertEqual(context.items[0].name, "Item 1")
        context.add(item2)
        XCTAssertEqual(context.items.count, 1)
        XCTAssertEqual(context.items[0].name, "Item 2")
    }

    func test_addItems_canAddMultipleItems() {
        let item1 = TestAppItem()
        let item2 = TestAppItem()
        context.add([item1, item2])
        XCTAssertEqual(context.items.count, 2)
        XCTAssertEqual(context.items[0].id, item1.id)
        XCTAssertEqual(context.items[1].id, item2.id)
    }

    func test_addItems_canReplaceExistingItems() {
        let item1 = TestAppItem(name: "Item 1")
        var item2 = item1
        item2.name = "Item 2"
        context.add([item1, item2])
        XCTAssertEqual(context.items.count, 1)
        XCTAssertEqual(context.items[0].name, "Item 2")
    }

    func test_removeItem_canRemoveSingleItem() {
        let item = TestAppItem()
        context.add(item)
        XCTAssertEqual(context.items.count, 1)
        context.remove(item)
        XCTAssertEqual(context.items.count, 0)
    }

    func test_removeItems_canRemoveMultipleItems() {
        let item1 = TestAppItem()
        let item2 = TestAppItem()
        context.add([item1, item2])
        XCTAssertEqual(context.items.count, 2)
        context.remove(item1)
        XCTAssertEqual(context.items.count, 1)
        XCTAssertEqual(context.items[0].id, item2.id)
    }
}
