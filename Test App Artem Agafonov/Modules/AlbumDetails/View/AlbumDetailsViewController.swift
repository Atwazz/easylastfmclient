//
//  AlbumDetailsViewController.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit

final class AlbumDetailsViewController: UIViewController {
    // MARK: - Private instance properties
    private let output: AlbumDetailsViewOutput
    
    // MARK: - Init
    init(output: AlbumDetailsViewOutput) {
        self.output = output
        super.init(nibName: Self.name, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: - AlbumDetailsViewInput
extension AlbumDetailsViewController: AlbumDetailsViewInput {
    
}
