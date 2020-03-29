//
//  UIBarButtonItem+ItemWithImage.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 29.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIBarButtonItem

extension UIBarButtonItem {
    static func with(image: UIImage?,
                     size: CGSize,
                     target: Any?,
                     action: Selector,
                     for controlEvents: UIControl.Event) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: action, for: controlEvents)
        let item = UIBarButtonItem(customView: button)
        item.customView?.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        item.customView?.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return item
    }
}
