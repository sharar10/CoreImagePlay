//
//  SimpleFilter.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 3/15/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import Foundation
import CoreImage

protocol SimpleFilter: Filter {
    var filter: CIFilter? { get }
}

extension SimpleFilter {
    func setInputImage(_ image: CIImage) {
        filter?.setValue(image, forKey: kCIInputImageKey)
    }

    var outputImage: CIImage? {
        return filter?.outputImage
    }
}
