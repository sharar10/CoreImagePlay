//
//  CroppedFilterTests.swift
//  CoreImagePlayTests
//
//  Created by Sharar Arzuk Rahman on 3/8/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import XCTest
@testable import CoreImagePlay

class CroppedFilterTests: XCTestCase {

    func test_createRectanglBars_returnsCIImage() {
        XCTAssertNotNil(CroppedFilter.createRectangleBars(onImageOfSize: CGSize(width: 10, height: 10)))
    }

}
