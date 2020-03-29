//
//  UITableView+RegisterCell.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 29.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
    func registerCell(_ type: NSObject.Type) {
        register(type.defaultNib, forCellReuseIdentifier: type.className)
    }
}
