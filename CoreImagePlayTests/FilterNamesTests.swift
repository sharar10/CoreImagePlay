//
//  FilterNamesTests.swift
//  CoreImagePlayTests
//
//  Created by Sharar Arzuk Rahman on 3/15/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import XCTest
@testable import CoreImagePlay

class FilterNamesTests: XCTestCase {
    let filters = FilterNames.allCases
    let badCase = "BadCase"

    func test_filterNames_canInitCIFilterFromRawValue() {
        filters.forEach { (filter) in
            let filter = CIFilter(name: filter.rawValue)
            XCTAssertNotNil(filter)
        }
    }

    func test_filterNames_doesNotInitCIFilterFromBadString() {
        let filter = CIFilter(name: badCase)
        XCTAssertNil(filter)
    }
}
