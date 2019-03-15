//
//  FilterNames.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 3/15/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import Foundation

enum FilterNames: String, CaseIterable {
    case sepia = "CISepiaTone"
    case vignetteEffect = "CIVignetteEffect"
    case monochrome = "CIPhotoEffectNoir"
    case rgbAdjustment = "CIColorMatrix"
    case crop = "CICrop"
    case sourceOverCompositing = "CISourceOverCompositing"
    case colorCube = "CIColorCube"
    case zoomBlur = "CIZoomBlur"
}
