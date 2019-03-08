//
//  VignetteFilter.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 2/27/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import Foundation
import CoreImage

struct VignetteEffectFilter: Filter {
    let filter: CIFilter?

    /// image size is used to determine the center of the image, radiusDecimal is expressed as a decimal (min 0, max 1) from the center relative to the smaller size dimension.
    init(imageSize: CGSize = CGSize(width: 1280, height: 720), radiusDecimal: CGFloat = 0.625) {
        let smallerDimension = min(imageSize.height, imageSize.width)
        let radius = smallerDimension * radiusDecimal
        filter = CIFilter(name: FilterNames.vignetteEffect.rawValue)
        filter?.setValue(CIVector(cgPoint: CGPoint(x: imageSize.width / 2, y: imageSize.height / 2)), forKey: kCIInputCenterKey)
        filter?.setValue(radius as NSNumber, forKey: kCIInputRadiusKey)
        filter?.setValue(0.95 as NSNumber, forKey: kCIInputIntensityKey)
    }
}
