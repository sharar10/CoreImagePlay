//
//  CameraViewController.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 3/18/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import UIKit
import AVKit

class CameraViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .hd1280x720
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: backCamera!)
            captureSession.addInput(input)
        } catch {
            return
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)

        let videoOutput = AVCaptureVideoDataOutput()



        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .default))
        captureSession.addOutput(videoOutput)

        captureSession.startRunning()
    }

}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer!)

        let comicEffect = CIFilter(name: "CIComicEffect")
        comicEffect!.setValue(cameraImage, forKey: kCIInputImageKey)
        let filteredImage = UIImage(ciImage: comicEffect!.outputImage!)
        DispatchQueue.main.async {
            self.imageView.image = filteredImage
        }

    }
}
