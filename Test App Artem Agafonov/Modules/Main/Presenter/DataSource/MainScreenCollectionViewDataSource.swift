//
//  MainScreenCollectionViewDataSource.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 22.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSFetchedResultsController
import UIKit.UICollectionView

final class MainScreenCollectionViewDataSource: NSObject {
    // MARK: - Public properties
    @DelayedImmutable var fetchedResultsController: NSFetchedResultsController<AlbumEntity>
    
    // MARK: - Private instance properties
    private let viewModelFactory: AlbumCollectionViewModelFactory
    private weak var collectionView: UICollectionView?
    
    // MARK: - Init
    init(viewModelFactory: AlbumCollectionViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        super.init()
    }
}

// MARK: - Public
extension MainScreenCollectionViewDataSource {
    func loadData() {
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            assertionFailure("Error occured: \(error.localizedDescription)")
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainScreenCollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        setCollectionView(collectionView)
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                              for: indexPath)
        guard let cell = reusableCell as? AlbumCollectionViewCell else {
            fatalError("Cell has unexpected type")
        }
        cell.update(with: viewModelFactory.model(for: fetchedResultsController.object(at: indexPath)))
        return cell
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension MainScreenCollectionViewDataSource: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.reloadData()
    }
}

// MARK: - Private
private extension MainScreenCollectionViewDataSource {
    var cellIdentifier: String {
        AlbumCollectionViewCell.className
    }
    
    func setCollectionView(_ newValue: UICollectionView) {
        guard collectionView != newValue else {
            return
        }
        collectionView = newValue
    }
}
