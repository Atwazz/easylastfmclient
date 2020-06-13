//
//  TracksView.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 29.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIView

final class TracksView: UIView {
    // MARK: - Private instance properties
    @IBOutlet private weak var stackView: UIStackView!
    @DelayedMutable private var itemSelectionBlock: (URL?) -> Void
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }
}

// MARK: - Public
extension TracksView {
    func setup(with models: [TrackViewModel],
               itemSelectionBlock: @escaping (URL?) -> Void) {
        self.itemSelectionBlock = itemSelectionBlock
        models.forEach { addTrackView(model: $0) }
    }
}

// MARK: - Private
private extension TracksView {
    func addTrackView(model: TrackViewModel) {
        let view = TrackView(frame: .zero)
        view.update(with: model) { [weak self] url in
            self?.itemSelectionBlock(url)
        }
        stackView.addArrangedSubview(view)
    }
}
