//
//  ArtistsSearchDataSource.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 29.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UITableView

final class ArtistsSearchDataSource: NSObject {
    // MARK: - Private instance properties
    private let modelFactory: ArtistCellModelFactory
    private var results = [Artist]()
    
    // MARK: - Init
    init(viewModelFactory: ArtistCellModelFactory) {
        modelFactory = viewModelFactory
        super.init()
    }
}

// MARK: - Public
extension ArtistsSearchDataSource {
    func clearResults() {
        results.removeAll()
    }
    
    func appendResults(_ chunk: [Artist]) {
        results.append(contentsOf: chunk)
    }
    
    func isItemLast(at indexpath: IndexPath) -> Bool {
       results.count == indexpath.row + 1
    }
    
    func item(at indexPath: IndexPath) -> Artist {
        results[indexPath.row]
    }
}

// MARK: - UITableViewDataSource
extension ArtistsSearchDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(of: ArtistCell.self, indexPath: indexPath)
        cell.update(with: modelFactory.viewModel(for: item(at: indexPath)))
        return cell
    }
}
