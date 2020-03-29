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
    @IBOutlet private weak var loadingContainer: UIView!
    @IBOutlet private weak var noDataContainer: UIView!
    @IBOutlet private weak var infoContainer: UIView!
    @IBOutlet private weak var artistImageView: UIImageView!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var namelabel: UILabel!
    @IBOutlet private weak var publishedDateLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tagsView: TagsView!
    @IBOutlet private weak var albumSummaryTextView: UITextView!
    @IBOutlet private weak var publishedDateZeroHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tracksView: TracksView!
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
        setupSubviews()
        output.viewIsReady()
    }
}

// MARK: - AlbumDetailsViewInput
extension AlbumDetailsViewController: AlbumDetailsViewInput {
    func update(albumSaved: Bool) {
        guard let height = navigationController?.navigationBar.bounds.size.height else {
            return
        }
        let width = height - 20
        let image = UIImage(named: albumSaved ? "star_filled" : "star_border")
        let item = UIBarButtonItem.with(image: image,
                                        size: CGSize(width: width, height: width),
                                        target: self,
                                        action: #selector(toggleAlbumIsSaved),
                                        for: .touchUpInside)
        navigationItem.rightBarButtonItem = item
    }
    
    func showLoadingIndicator() {
        infoContainer.isHidden = true
        noDataContainer.isHidden = true
        loadingContainer.isHidden = false
    }
    
    func showNoDataPlaceholder() {
        loadingContainer.isHidden = true
        infoContainer.isHidden = true
        noDataContainer.isHidden = false
    }
    
    func update(with model: AlbumDetailsViewModel) {
        showInfoContainer()
        updateImageView(with: model.imageURL)
        updateArtistImageView(with: model.artist.imageURL)
        artistNameLabel.text = model.artist.name
        namelabel.text = model.name
        updatePublishedDate(with: model.published)
        updateSummary(with: model.summary)
        tracksView.setup(with: model.tracks) { [weak self] trackUrl in
            self?.output.selectedTrack(with: trackUrl)
        }
    }
    
    func setup(with tagsDataSource: UICollectionViewDataSource) {
        tagsView.setup(dataSource: tagsDataSource,
                       layoutDelegate: tagsFlowLayout)
    }
}

// MARK: - Private: Actions
private extension AlbumDetailsViewController {
    @IBAction func artistInfoTapped(_ sender: Any) {
        output.artistInfoTapped()
    }
    
    @IBAction func albumNameTapped(_ sender: Any) {
        output.albumNameTapped()
    }
    
    @IBAction func albumImageTapped(_ sender: Any) {
        output.albumImageTapped()
    }
    
    @objc func closeButtonTapped() {
        output.closeButtonTapped()
    }
    
    @objc func toggleAlbumIsSaved() {
        output.toggleAlbumIsSaved()
    }
}

// MARK: - Private
private extension AlbumDetailsViewController {
    func setupSubviews() {
        tagsFlowLayout.setup { [weak self] indexPath in
            self?.output.selectedTag(at: indexPath)
        }
        albumSummaryTextView.textContainerInset = .zero
        setupNavBar()
    }
    
    func setupNavBar() {
        let closeItem = UIBarButtonItem(barButtonSystemItem: .close,
                                        target: self,
                                        action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = closeItem
    }
    
    func showInfoContainer() {
        noDataContainer.isHidden = true
        loadingContainer.isHidden = true
        infoContainer.isHidden = false
    }
    
    func updateImageView(with url: URL?) {
        imageView.setImage(with: url, placeholderName: "no_data")
    }
    
    func updateArtistImageView(with url: URL?) {
        artistImageView.setImage(with: url, placeholderName: "avatar_placeholder")
    }
    
    func updateSummary(with text: String?) {
        albumSummaryTextView.text = text
        albumSummaryTextView.isHidden = text?.count == 0
    }
    
    func updatePublishedDate(with date: String?) {
        publishedDateZeroHeightConstraint.isActive = date == nil
        publishedDateLabel.text = date
    }
}
