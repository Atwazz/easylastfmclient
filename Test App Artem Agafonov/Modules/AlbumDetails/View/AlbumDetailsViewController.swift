//
//  AlbumDetailsViewController.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit
import AlamofireImage

final class AlbumDetailsViewController: UIViewController {
    // MARK: - Public instance properties
    @DelayedImmutable var output: AlbumDetailsViewOutput
    
    // MARK: - Private instance properties
    @IBOutlet private weak var artistImageView: UIImageView!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var namelabel: UILabel!
    @IBOutlet private weak var publishedDateLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tagsView: TagsView!
    @IBOutlet private weak var albumSummaryTextView: UITextView!
    
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
    
    func update(with model: AlbumDetailsViewModel) {
        updateImageView(with: model.imageURL)
        updateArtistImageView(with: model.artist.imageURL)
        artistNameLabel.text = model.artist.name
        namelabel.text = model.name
        publishedDateLabel.text = model.published ?? "Unknown published date"
        updateSummary(with: model.summary)
    }
    
    func setup(with tagsDataSource: UICollectionViewDataSource) {
        tagsView.setup(dataSource: tagsDataSource,
                       layoutDelegate: tagsFlowLayout)
    }
}

// MARK: - Private
private extension AlbumDetailsViewController {
    func updateImageView(with url: URL?) {
        imageView.setImage(with: url, placeholderName: "AlbumImagePlaceholder")
    }
    
    func updateArtistImageView(with url: URL?) {
        artistImageView.setImage(with: url, placeholderName: "ArtistImagePlaceholder")
    }
    
    func updateSummary(with text: String?) {
        albumSummaryTextView.text = text
        albumSummaryTextView.isHidden = text?.count == 0
    }
}
