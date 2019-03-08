//
//  CropFilter.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 2/27/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import Foundation
import CoreImage
import UIKit

// raw image -> crop -> overlay -> out
struct CroppedFilter: Filter {
    var filter: CIFilter?
    var secondFilter: CIFilter?

    var outputImage: CIImage? {
        return secondFilter?.outputImage
    }

    init() {
        filter = CIFilter(name: FilterNames.crop.rawValue)
        //x/y/width/height
        let vector = CIVector(x: 0, y: 100, z: 300, w: 720)
        filter?.setValue(vector, forKey: "inputRectangle")

        secondFilter = CIFilter(name: "CISourceOverCompositing")
        secondFilter?.setValue(filter?.outputImage, forKey: kCIInputImageKey)
        secondFilter?.setValue(CroppedFilter.createBlackBackground(for: CGSize(width: 1280, height: 720)), forKey: "inputBackgroundImage")
    }

    static func createBlackBackground(for size: CGSize) -> CIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { (context) in
            let aSize = context.format.bounds.size
            UIColor.black.setFill()
            context.fill(CGRect(x: 0, y: 0, width: aSize.width, height: aSize.height))
        }
        return CIImage(image: image)!
    }
}

