//
//  UIView+LoadFromNib.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIView

extension UIView {
    func loadFromNib() {
        guard let view = with(nib: type(of: self).nib) else {
            fatalError("Failed to instantiate nib \(Self.nib)")
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        fill(with: view)
    }
}

// MARK: - Private
private extension UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    func with(nib: UINib) -> UIView? {
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
    
    func fill(with view: UIView) {
        addSubview(view)
        let views = ["view": view]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                                 options: .alignAllLastBaseline,
                                                                 metrics: nil,
                                                                 views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|",
                                                                   options: .alignAllLastBaseline,
                                                                   metrics: nil,
                                                                   views: views)
        addConstraints(verticalConstraints + horizontalConstraints)
    }
}
