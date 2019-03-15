//
//  ChainableFilter.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 3/15/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import Foundation
import CoreImage

class FilterChain: Filter {
    private var filters: [Filter]
    var outputImage: CIImage?

    init(fromFilters filters: [Filter]) {
        self.filters = filters
    }

    func setInputImage(_ image: CIImage) {
        var currentInputImage: CIImage! = image

        filters.forEach { aFilter in
            aFilter.setInputImage(currentInputImage)
            currentInputImage = aFilter.outputImage
            self.outputImage = aFilter.outputImage
        }
    }
}
