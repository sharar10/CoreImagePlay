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
    func setInputImage(_ image: CIImage)
    var outputImage: CIImage? { get }
}
