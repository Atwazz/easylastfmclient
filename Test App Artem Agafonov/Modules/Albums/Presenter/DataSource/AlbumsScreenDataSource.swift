//
//  AlbumsScreenDataSource.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UITableView

final class AlbumsScreenDataSource: NSObject {
    // MARK: - Private instance properties
    private let viewModelFactory: AlbumCellModelFactory
    private let modelFactory: AlbumModelFactory
    private var rawrResults = [Album]()
    private var results = [AlbumModel]()
    @ThreadSafe private var artistId: PSObjectID?
    
    // MARK: - Init
    init(viewModelFactory: AlbumCellModelFactory,
         modelFactory: AlbumModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.modelFactory = modelFactory
    }
}

// MARK: - Public
extension AlbumsScreenDataSource {
    func clearResults() {
        results.removeAll()
        rawrResults.removeAll()
    }
    
    func appendResults(_ chunk: [Album], completion: @escaping () -> Void) {
        modelFactory.models(for: chunk, artistId: artistId) { [weak self] models in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.rawrResults.append(contentsOf: chunk)
                self.results.append(contentsOf: models)
                completion()
            }
        }
    }
    
    func isItemLast(at indexpath: IndexPath) -> Bool {
       results.count == indexpath.row + 1
    }
    
    func item(at indexPath: IndexPath) -> AlbumModel {
        results[indexPath.row]
    }
    
    func updateArtistId(_ newValue: PSObjectID?, completion: @escaping () -> Void) {
        artistId = newValue
        updateResults(completion: completion)
    }
}

// MARK: - UITableViewDelegate
extension AlbumsScreenDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(of: AlbumCell.self, indexPath: indexPath)
        cell.update(with: viewModelFactory.viewModel(for: item(at: indexPath)))
        return cell
    }
}

// MARK: - Private
private extension AlbumsScreenDataSource {
    func updateResults(completion: @escaping () -> Void) {
        guard rawrResults.count > 0 else {
            completion()
            return
        }
        modelFactory.models(for: rawrResults, artistId: artistId) { [weak self] models in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.results = models
                completion()
            }
        }
    }
}
