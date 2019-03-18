//
//  GrayscaleFilterTests.swift
//  CoreImagePlayTests
//
//  Created by Sharar Arzuk Rahman on 3/18/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import XCTest
@testable import CoreImagePlay

class GrayscaleFilterTests: XCTestCase {

    func test_init_doesInitFilter() {
        let sut = GrayscaleFilter()
        XCTAssertNotNil(sut.filter)
    }

}
