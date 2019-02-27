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
    let reuseIdentifier = "FilterNameCell"

    // MARK: Nested types
    private enum Segues: String {
        case filterPreview
    }

    // MARK: Interface builder outlets
    @IBOutlet weak var filtersTableView: UITableView!

    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let segueName = Segues(rawValue: identifier) else {
            fatalError()
        }
        switch segueName {
        case .filterPreview:
            return
        }
    }
}

// MARK: UITableViewDataSource methods
extension FilterSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
            return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
        cell.textLabel?.text = "TEST TO MAKE SURE IT WORKS"
        return cell
    }
}

// MARK: UITableViewDelegate methods
extension FilterSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Segues.filterPreview.rawValue, sender: nil)
    }
}

