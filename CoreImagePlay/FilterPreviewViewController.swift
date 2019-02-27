//
//  FilterPreviewViewController.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 2/27/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class FilterPreviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        playVideo()
    }

    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "720PVideo", ofType: "mp4") else {
            fatalError()
        }
        let url = URL(fileURLWithPath: path)
        let filter = CIFilter(name: "CISepiaTone")!
        let asset = AVAsset(url: url)
        let composition = AVVideoComposition(asset: asset) { (filteringRequest) in
            let source = filteringRequest.sourceImage.clampedToExtent()
            filter.setValue(source, forKey: kCIInputImageKey)

            filter.setValue(1.0, forKey: kCIInputIntensityKey)
            let output = filter.outputImage!.cropped(to: filteringRequest.sourceImage.extent)

            filteringRequest.finish(with: output, context: nil)
        }
        let playerItem = AVPlayerItem(asset: asset)
        playerItem.videoComposition = composition
        let player = AVPlayer(playerItem: playerItem)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}
