//
//  ArtistsSearchViewController.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit

final class ArtistsSearchViewController: UIViewController {
    // MARK: - Private instance properties
    private let output: ArtistsSearchViewOutput
    
    // MARK: - Init
    init(output: ArtistsSearchViewOutput) {
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

// MARK: - ArtistsSearchViewInput
extension ArtistsSearchViewController: ArtistsSearchViewInput {
    
}
