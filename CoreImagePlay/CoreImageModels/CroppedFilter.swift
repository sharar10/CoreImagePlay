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

struct CroppedFilter: Filter {
    var filter: CIFilter?
    let blackBars: CIImage

    init(imageSize: CGSize, cropXPercent: CGFloat, y: CGFloat, widthPercent: CGFloat, heightPercent: CGFloat) {
        blackBars = CroppedFilter.createRectangleBars(onImageOfSize: imageSize)
        filter = CIFilter(name: FilterNames.crop.rawValue)
        filter?.setValue(blackBars, forKey: kCIInputBackgroundImageKey)
    }

    static func createRectangleBars(onImageOfSize size: CGSize) -> CIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { (context) in
            let size = context.format.bounds.size
            UIColor.black.setFill()
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: 100))
        }
        return CIImage(image: image)!
    }

}

