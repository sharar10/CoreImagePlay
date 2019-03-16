//
//  HalfMirrorFilter.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 3/15/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import Foundation
import CoreImage

struct HalfMirrorFilter: Filter {
    private let filter: HalfMirrorTransform?

    func setInputImage(_ image: CIImage) {
        filter?.inputImage = image
    }

    var outputImage: CIImage? {
        return filter?.outputImage
    }

    init(leftOnRight: Bool = true) {
        filter = HalfMirrorTransform(lOnR: leftOnRight)
    }


}

fileprivate class HalfMirrorTransform: CIFilter {
    private let kernel: CIKernel
    var inputImage: CIImage?
    var lOnR: Bool

    init(lOnR: Bool) {
        let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "horizontal_mirror_transform", fromMetalLibraryData: data)
        self.lOnR = lOnR
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {
            return nil
        }
        let value: Float
        if lOnR {
            value = 1
        } else {
            value = -1
        }
        return kernel.apply(extent: inputImage.extent, roiCallback: { $1} , arguments: [inputImage, value])
    }


}
