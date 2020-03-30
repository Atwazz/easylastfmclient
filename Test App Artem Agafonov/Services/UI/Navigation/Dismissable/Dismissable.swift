//
//  Dismissable.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol Dismissable: class {
    var dismissListener: DismissListener? { get }
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}

extension Dismissable {
    func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissListener?.dismissable(willBeDismissed: self)
        dismiss(animated: flag) { [weak self] in
            guard let self = self else { return }
            self.dismissListener?.dismissable(didDismiss: self)
            completion?()
        }
    }
}
