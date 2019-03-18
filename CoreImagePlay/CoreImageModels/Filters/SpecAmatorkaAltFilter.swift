//
//  SpecAmatorkaAltFilter.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 3/17/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import Foundation
import CoreImage
import UIKit

/// - WARNING: strange red artifacts appear when attempting to replay a video with this filter. Currently unable to determine why that happens.
struct SpecAmatorkaFilterAlt: Filter {
    private let filter: LookupFilter?

    func setInputImage(_ image: CIImage) {
        filter?.inputImage = image.clampedToExtent()
    }

    var outputImage: CIImage? {
        return filter?.outputImage
    }

    init(imageName: String) {
        let lookupImage = UIImage(named: imageName)!
        let ciLookupImage = CIImage(image: lookupImage)!
        filter = LookupFilter(lookupImage: ciLookupImage)
    }
}

fileprivate class LookupFilter: CIFilter {
    private let kernel: CIKernel
    var inputImage: CIImage?
    var lookupImage: CIImage

    init(lookupImage: CIImage) {
        let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "lookup_filter", fromMetalLibraryData: data)
        self.lookupImage = lookupImage
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {
            return nil
        }
        return kernel.apply(extent: inputImage.extent, roiCallback: { $1 }, arguments: [inputImage, lookupImage])
    }

}
