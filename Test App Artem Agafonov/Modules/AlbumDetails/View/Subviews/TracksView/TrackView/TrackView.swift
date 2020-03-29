//
//  TrackView.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 29.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIView

final class TrackView: UIView {
    // MARK: - Private instance properties
    @IBOutlet private weak var rankLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @DelayedMutable private var url: URL?
    @DelayedImmutable private var selectionBlock: (URL?) -> Void
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }
    
    @IBAction func tapHappened(_ sender: Any) {
        selectionBlock(url)
    }
}

// MARK: - Public
extension TrackView {    
    func update(with model: TrackViewModel,
                selectionBlock: @escaping (URL?) -> Void) {
        rankLabel.text = model.rank
        nameLabel.text = model.name
        durationLabel.text = model.duration
        url = model.url
        self.selectionBlock = selectionBlock
    }
}
