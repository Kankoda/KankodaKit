//
//  NamedTests.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KankodaKit
import XCTest

final class NamedTests: XCTestCase {

    func test_hasNameTrimsName() {
        let item1 = TestAppItem(name: "   ")
        let item2 = TestAppItem(name: "my card")

        XCTAssertEqual(item1.hasName, false)
        XCTAssertEqual(item2.hasName, true)
    }

    func test_hasNameWithFallbackReturnsFallbackIfNameIsEmpty() {
        let item1 = TestAppItem(name: "   ")
        let item2 = TestAppItem(name: "my card")

        XCTAssertEqual(item1.name(fallback: "foo"), "foo")
        XCTAssertEqual(item2.name(fallback: "foo"), "my card")
    }
}
