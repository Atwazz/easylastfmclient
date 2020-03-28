//
//  AlbumDetailsViewController.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit

final class AlbumDetailsViewController: UIViewController {
    // MARK: - Public instance properties
    @DelayedImmutable var output: AlbumDetailsViewOutput
    
    // MARK: - Private instance properties
    @IBOutlet private weak var tagsView: TagsView!
    private let tagsFlowLayout: CollectionViewDelegateFlowLayout
    
    // MARK: - Init
    init(tagsFlowLayout: CollectionViewDelegateFlowLayout) {
        self.tagsFlowLayout = tagsFlowLayout
        super.init(nibName: Self.name, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsFlowLayout.setup { [weak self] indexPath in
            self?.output.selectedTag(at: indexPath)
        }
        output.viewIsReady()
    }
}

// MARK: - AlbumDetailsViewInput
extension AlbumDetailsViewController: AlbumDetailsViewInput {
    func showLoadingIndicator() {
        
    }
    
    func showNoDataPlaceholder() {
        
    }
    
    func setup(with tagsDataSource: UICollectionViewDataSource) {
        tagsView.setup(dataSource: tagsDataSource,
                       layoutDelegate: tagsFlowLayout)
    }
}
