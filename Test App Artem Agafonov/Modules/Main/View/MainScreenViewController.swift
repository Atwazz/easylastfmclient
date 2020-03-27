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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private let minimumItemSpacing: CGFloat = 10
    private let itemsPerRow: CGFloat = 2
    
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
        output.viewIsReady()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        output.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = minimumItemSpacing * (itemsPerRow - 1)
        let availableWidth = min(collectionView.bounds.width, collectionView.bounds.height) - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        minimumItemSpacing
    }
}

// MARK: - Private
private extension MainScreenViewController {
    var searchButton: UIBarButtonItem {
        UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSearchButtonTapped(_:)))
    }
    
    func setup() {
        title = "Saved Albums"
        navigationItem.rightBarButtonItem = searchButton
        setupCollectionView()
    }
    
    func setupCollectionView() {
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
