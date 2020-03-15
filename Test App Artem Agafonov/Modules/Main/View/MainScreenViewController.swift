//
//  MainScreenViewController.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit

final class MainScreenViewController: UIViewController {
    // MARK: - Public instance properties
    @DelayedImmutable var output: MainScreenViewOutput
    
    // MARK: - Private instance properties
    
    // MARK: - Init
    init() {
        super.init(nibName: Self.name, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

// MARK: - Private
private extension MainScreenViewController {
    var searchButton: UIBarButtonItem {
        UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSearchButtonTapped(_:)))
    }
    
    func setup() {
        navigationItem.rightBarButtonItem = searchButton
    }
}

// MARK: - Private: Actions
private extension MainScreenViewController {
    @objc func openSearchButtonTapped(_ sender: Any) {
        output.openSearchButtonTapped()
    }
}

// MARK: - MainScreenViewInput
extension MainScreenViewController: MainScreenViewInput {
    
}
