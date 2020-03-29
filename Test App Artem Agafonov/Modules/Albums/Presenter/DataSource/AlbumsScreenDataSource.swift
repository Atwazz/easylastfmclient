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
    private var results = [Album]()
    @DelayedImmutable private var artist: Artist
    
    // MARK: - Init
    init(viewModelFactory: AlbumCellModelFactory) {
        self.viewModelFactory = viewModelFactory
    }
}

// MARK: - Public
extension AlbumsScreenDataSource {
    func setup(for artist: Artist) {
        self.artist = artist
    }
    
    func clearResults() {
        results.removeAll()
    }
    
    func appendResults(_ chunk: [Album]) {
        results.append(contentsOf: chunk)
    }
    
    func isItemLast(at indexpath: IndexPath) -> Bool {
       results.count == indexpath.row + 1
    }
    
    func item(at indexPath: IndexPath) -> Album {
        results[indexPath.row]
    }
}

// MARK: - UITableViewDelegate
extension AlbumsScreenDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(of: AlbumCell.self, indexPath: indexPath)
        cell.update(with: viewModelFactory.viewModel(for: item(at: indexPath),
                                                     artist: artist))
        return cell
    }
}
