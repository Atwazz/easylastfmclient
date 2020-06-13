//
//  MainScreenCollectionViewDataSource.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 22.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSFetchedResultsController
import UIKit.UICollectionView

final class MainScreenCollectionViewDataSource: NSObject {
    // MARK: - Private instance properties
    private let viewModelFactory: AlbumCollectionViewModelFactory
    private weak var collectionView: UICollectionView?
    @DelayedImmutable private var fetchedResultsController: NSFetchedResultsController<AlbumEntity>
    
    // MARK: - Init
    init(viewModelFactory: AlbumCollectionViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        super.init()
    }
}

// MARK: - Public
extension MainScreenCollectionViewDataSource {
    func setup(with resultsController: NSFetchedResultsController<AlbumEntity>) {
        fetchedResultsController = resultsController
        fetchedResultsController.delegate = self
    }
    
    func loadData() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            assertionFailure("Error occured: \(error.localizedDescription)")
        }
    }
    
    func albumID(at indexPath: IndexPath) -> PSObjectID {
        fetchedResultsController.object(at: indexPath).id
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
        let cell = collectionView.dequeueCell(of: AlbumCollectionViewCell.self,
                                              indexPath: indexPath)
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
    func setCollectionView(_ newValue: UICollectionView) {
        guard collectionView != newValue else {
            return
        }
        collectionView = newValue
    }
}
