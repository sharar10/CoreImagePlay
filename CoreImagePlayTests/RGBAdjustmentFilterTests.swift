//
//  RGBAdjustmentFilterTests.swift
//  CoreImagePlayTests
//
//  Created by Sharar Arzuk Rahman on 3/18/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import XCTest
@testable import CoreImagePlay

class RGBAdjustmentFilterTests: XCTestCase {

    func test_init_doesInitWithRGBValues() {
        let red: CGFloat = 0.3
        let green: CGFloat = 0.5
        let blue: CGFloat = 0.1

        let sut = RGBAdjustmentFilter(red: red, green: green, blue: blue)

        XCTAssertNotNil(sut.filter)

        let filter = sut.filter!

        let redVal = filter.value(forKey: "inputRVector") as! CIVector
        let greenVal = filter.value(forKey: "inputGVector") as! CIVector
        let blueVal = filter.value(forKey: "inputBVector") as! CIVector

        XCTAssertEqual(redVal.value(at: 0), red)
        XCTAssertEqual(greenVal.value(at: 1), green)
        XCTAssertEqual(blueVal.value(at: 2), blue)
    }
}
