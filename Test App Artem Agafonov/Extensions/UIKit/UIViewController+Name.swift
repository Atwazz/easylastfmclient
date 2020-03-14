//
//  UIViewController+Name.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    static var name: String {
        String(describing: self)
    }
}
