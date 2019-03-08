//
//  ViewController.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 2/27/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class FilterSelectionViewController: UIViewController {
    // MARK: stored properties
    private let reuseIdentifier = "FilterNameCell"

    // MARK: Interface builder outlets
    @IBOutlet weak var filtersTableView: UITableView!

    // MARK: nested types
    private enum Segues: String {
        case showImage
    }
    private enum Section: Int, CaseIterable {
        case originalVideo = 0
        case processedVideo
        case originalImage
        case processedImage
    }

    private enum ProcessedSectionRow: Int, CaseIterable {
        case sepia = 0
        case grayscale
        case specAmatorka
        case vignetteEffect
        case rgbAdjustment

        var name: String {
            switch self {
            case .sepia:
                return "Sepia"
            case .grayscale:
                return "Grayscale"
            case .specAmatorka:
                return "SpecAmatorka"
            case .vignetteEffect:
                return "Vignette effect"
            case .rgbAdjustment:
                return "RGB Adjustment"
            }
        }
    }

    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch Segues(rawValue: segue.identifier!)! {
        case .showImage:
            let destination = segue.destination as! FilterImagePreviewViewController
            destination.image = sender as? UIImage
        }
    }
}

// MARK: UITableViewDataSource methods
extension FilterSelectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .originalVideo:
            return 1
        case .processedVideo:
            return ProcessedSectionRow.allCases.count
        case .originalImage:
            return 1
        case .processedImage:
            return ProcessedSectionRow.allCases.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
            return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
        switch Section(rawValue: indexPath.section)! {
        case .originalVideo:
            cell.textLabel?.text = "Original video"
        case .processedVideo:
            cell.textLabel?.text = ProcessedSectionRow(rawValue: indexPath.row)!.name
        case .originalImage:
            cell.textLabel?.text = "Original image"
        case .processedImage:
            cell.textLabel?.text = ProcessedSectionRow(rawValue: indexPath.row)!.name
        }
        return cell
    }
}

// MARK: UITableViewDelegate methods
extension FilterSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section)! {
        case .originalVideo:
            playVideo()
        case .processedVideo:
            let filter = self.filter(for: indexPath)
            playVideo(withFilter: filter)
        case .originalImage:
            performSegue(withIdentifier: Segues.showImage.rawValue, sender: UIImage(named: "processing-image"))
        case .processedImage:
            let fileURL = Bundle.main.url(forResource: "processing-image", withExtension: "jpg")!
            let image = CIImage(contentsOf: fileURL)!
            let filter = self.filter(for: indexPath)
            performSegue(withIdentifier: Segues.showImage.rawValue, sender: filterImage(with: image, filter: filter))
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Section(rawValue: section)! {
        case .originalVideo:
            return "Unprocessed video"
        case .processedVideo:
            return "Processed video"
        case .originalImage:
            return "Unprocessed image"
        case .processedImage:
            return "Processed image"
        }
    }
}

extension FilterSelectionViewController {
    private func filter(for indexPath: IndexPath) -> Filter {
        switch ProcessedSectionRow(rawValue: indexPath.row)! {
        case .sepia:
            return SepiaFilter(initialIntensity: 1.0) as Filter
        case .grayscale:
            return GrayscaleFilter() as Filter
        case .specAmatorka:
            return SpecAmatorkaFilter(imageName: "lookup_amatorka") as Filter
        case .vignetteEffect:
            return VignetteEffectFilter() as Filter
        case .rgbAdjustment:
            return RGBAdjustmentFilter(red: 0.5, green: 0.2, blue: 1.0) as Filter
        }
    }

    func filterImage(with image: CIImage, filter: Filter) -> UIImage {
        filter.setInputImage(image)
        return UIImage(ciImage: filter.outputImage!)
    }

    private func playVideo(withFilter filter: Filter) {
        playVideo { (asset) -> AVVideoComposition in
            return AVVideoComposition(asset: asset) { (filteringRequest) in
                let source = filteringRequest.sourceImage.clampedToExtent()
                filter.setInputImage(source)
                let output = filter.outputImage!.cropped(to: filteringRequest.sourceImage.extent)

                filteringRequest.finish(with: output, context: nil)
            }
        }
    }

    private func playVideo(composition: ((AVAsset) -> AVVideoComposition)? = nil) {
        guard let path = Bundle.main.path(forResource: "720PVideo", ofType: "mp4") else {
            fatalError("Video not found in bundle.")
        }
        let url = URL(fileURLWithPath: path)
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        if let composition = composition {
            playerItem.videoComposition = composition(asset)
        }
        let player = AVPlayer(playerItem: playerItem)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}

