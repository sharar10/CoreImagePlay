//
//  ZoomBlurFilter.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 3/15/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import Foundation
import CoreImage

struct ZoomBlurFilter: SimpleFilter {
    let filter: CIFilter?

    // Leave blur size at 1.0
    init(imageCenter: CGPoint = CGPoint(x: 1280/2, y: 720/2), inputAmount: CGFloat = 1.0) {
        self.filter = CIFilter(name: FilterNames.zoomBlur.rawValue)
        let centerVector = CIVector(x: imageCenter.x, y: imageCenter.y)
        filter?.setValue(centerVector, forKey: kCIInputCenterKey)
        filter?.setValue(inputAmount as NSNumber, forKey: kCIInputAmountKey)
    }
}
