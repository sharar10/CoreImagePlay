//
//  FilterPreviewViewController.swift
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 2/27/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

import Foundation
import UIKit

class FilterImagePreviewViewController: UIViewController {

    // MARK: Stored properties
    var image: UIImage?

    // MARK: Interface builder
    @IBOutlet weak var imagePreviewImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        scrollView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 50)
        self.imagePreviewImageView.image = image
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        let centerOffsetX = (scrollView.contentSize.width - scrollView.frame.size.width) / 2
        let centerOffsetY = (scrollView.contentSize.height - scrollView.frame.size.height) / 2
        let centerPoint = CGPoint(x: centerOffsetX, y: centerOffsetY)
        scrollView.setContentOffset(centerPoint, animated: true)
    }
}

extension FilterImagePreviewViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imagePreviewImageView
    }
}
