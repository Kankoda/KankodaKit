//
//  SortableTests.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KankodaKit
import XCTest

final class SortableTests: XCTestCase {

    let orderedItems: [TestAppItem] = {
        var item1 = TestAppItem(name: "card1", sortOrder: 3)
        var item2 = TestAppItem(name: "card2", sortOrder: 2)
        var item3 = TestAppItem(name: "card3", sortOrder: 1)
        return [item1, item2, item3]
    }()

    func test_maxSortOrderReturnsZeroForEmptyCollection() {
        let items = [TestAppItem]()
        XCTAssertEqual(items.maxSortOrder, 0)
    }

    func test_maxSortOrderReturnsTheLargestValueInTheCollection() {
        XCTAssertEqual(orderedItems.maxSortOrder, 3)
    }

    func test_minSortOrderReturnsZeroForEmptyCollection() {
        let items = [TestAppItem]()
        XCTAssertEqual(items.minSortOrder, 0)
    }

    func test_minSortOrderReturnsTheSmallestValueInTheCollection() {
        XCTAssertEqual(orderedItems.minSortOrder, 1)
    }

    func test_needsRefreshedSortOrderIfAnyCardsHaveTheSameSortOrder() {
        XCTAssertFalse(orderedItems.needsRefreshedSortOrder)
        let items = orderedItems
        var item = items[0]
        item.sortOrder = 1
        let sameOrder = [items[0], item, items[2]]
        XCTAssertTrue(sameOrder.needsRefreshedSortOrder)
    }

    func test_needsRefreshedSortOrderHandlesEmptyCollection() {
        let empty = [TestAppItem]()
        XCTAssertFalse(empty.needsRefreshedSortOrder)
    }

    func test_sortingSortsOnSortOrder() {
        let items = orderedItems
        let result = items.sortedBySortOrder()
        XCTAssertEqual(result[0].id, items[2].id)
        XCTAssertEqual(result[1].id, items[1].id)
        XCTAssertEqual(result[2].id, items[0].id)
    }

    func test_withRefreshedSortOrderReturnsResortedArray() {
        let items = orderedItems.withRefreshedSortOrder()
        XCTAssertEqual(items[0].sortOrder, 0)
        XCTAssertEqual(items[0].name, "card1")
        XCTAssertEqual(items[1].sortOrder, 1)
        XCTAssertEqual(items[1].name, "card2")
        XCTAssertEqual(items[2].sortOrder, 2)
        XCTAssertEqual(items[2].name, "card3")
    }
}
