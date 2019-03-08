//
//  ImageFilters.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 2/27/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import Foundation
import CoreImage

struct RGBAdjustmentFilter: Filter {
    let filter: CIFilter?

    /// Color values are normalized to 1
    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        filter = CIFilter(name: FilterNames.rgbAdjustment.rawValue)
        let red = CIVector(x: red, y: 0, z: 0, w: 0)
        let green = CIVector(x: 0, y: green, z: 0, w: 0)
        let blue = CIVector(x: 0, y: 0, z: blue, w: 0)
        let keysAndValues: [String: CIVector] = [
            "inputRVector": red,
            "inputGVector": green,
            "inputBVector": blue
        ]
        for (key, value) in keysAndValues {
            filter?.setValue(value, forKey: key)
        }
    }
}
