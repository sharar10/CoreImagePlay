//
//  SepiaFilterTests.swift
//  CoreImagePlayTests
//
//  Created by Sharar Arzuk Rahman on 3/18/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import XCTest
@testable import CoreImagePlay

class SepiaFilterTests: XCTestCase {

    func test_init_doesInitializeWithRightIntensity() {
        let intensity = 0.3 as NSNumber
        let sut = SepiaFilter(initialIntensity: intensity)
        XCTAssertNotNil(sut.filter)
        XCTAssertEqual(sut.filter?.value(forKey: kCIInputIntensityKey) as? NSNumber, intensity)

    }
}
