//
//  ImageFilter.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 2/27/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import Foundation
import CoreImage

protocol Filter {
    var filter: CIFilter? { get }
    func setInputImage(_ image: CIImage)
    func setBackgroundImage(_ image: CIImage)
    var outputImage: CIImage? { get }
}

extension Filter {
    func setInputImage(_ image: CIImage) {
        filter?.setValue(image, forKey: kCIInputImageKey)
    }

    func setBackgroundImage(_ image: CIImage) {
        filter?.setValue(image, forKey: "inputBackgroundImage")
    }

    var outputImage: CIImage? {
        return filter?.outputImage
    }
}

enum FilterNames: String, CaseIterable {
    case sepia = "CISepiaTone"
    case vignetteEffect = "CIVignetteEffect"
    case monochrome = "CIPhotoEffectNoir"
    case rgbAdjustment = "CIColorMatrix"
    case crop = "CICrop"
}
