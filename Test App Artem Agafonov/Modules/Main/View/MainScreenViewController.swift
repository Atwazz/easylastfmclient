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
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    private let flowLayout: CollectionViewDelegateFlowLayout
    
    // MARK: - Init
    init(layoutDelegate: CollectionViewDelegateFlowLayout) {
        flowLayout = layoutDelegate
        super.init(nibName: Self.name, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        output.viewIsReady()
    }
}

// MARK: - Private
private extension MainScreenViewController {
    var searchButton: UIBarButtonItem {
        UIBarButtonItem(barButtonSystemItem: .search,
                        target: self,
                        action: #selector(openSearchButtonTapped(_:)))
    }
    
    func setup() {
        title = "Saved Albums"
        navigationItem.rightBarButtonItem = searchButton
        setupCollectionView()
    }
    
    func setupCollectionView() {
        flowLayout.setup { [weak self] indexPath in
            self?.output.didSelectItem(at: indexPath)
        }
        collectionView.delegate = flowLayout
        collectionView.registerCell(AlbumCollectionViewCell.self)
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
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func setup(dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
}
