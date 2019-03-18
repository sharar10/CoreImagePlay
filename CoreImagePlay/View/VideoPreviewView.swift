//
//  PreviewView.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 3/18/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import UIKit
import AVKit

class VideoPreviewView: UIView {

    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }

    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
