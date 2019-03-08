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

// raw image -> CICrop -> CISourceOverCompositing with black background (cache it) -> out
struct CroppedFilter: Filter {
    var filter: CIFilter?
    var secondFilter: CIFilter?
    private var imageSize: CGSize

    private lazy var blackBackground: CIImage = {
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let image = renderer.image { (context) in
            let aSize = context.format.bounds.size
            UIColor.black.setFill()
            context.fill(CGRect(x: 0, y: 0, width: aSize.width, height: aSize.height))
        }
        return CIImage(image: image)!
    }()

    func setInputImage(_ image: CIImage) {
        filter?.setValue(image, forKey: kCIInputImageKey)
        secondFilter?.setValue(filter?.outputImage, forKey: kCIInputImageKey)
    }

    var outputImage: CIImage? {
        return secondFilter?.outputImage
    }

    init(imageSize: CGSize, cropRelativeOrigin: (x: CGFloat, y: CGFloat), cropRelativeSize: (width: CGFloat, height: CGFloat)) {
        self.imageSize = imageSize
        filter = CIFilter(name: FilterNames.crop.rawValue)
        //x/y/width/height
        let xRelative = imageSize.width * cropRelativeOrigin.x
        let yRelative = imageSize.height * cropRelativeOrigin.y
        let widthRelative = imageSize.width * cropRelativeSize.width
        let heightRelative = imageSize.height * cropRelativeSize.height
        let vector = CIVector(x: xRelative, y: yRelative, z: widthRelative, w: heightRelative)
        filter?.setValue(vector, forKey: "inputRectangle")

        secondFilter = CIFilter(name: "CISourceOverCompositing")
        secondFilter?.setValue(blackBackground, forKey: "inputBackgroundImage")
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

