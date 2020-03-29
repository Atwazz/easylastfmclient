//
//  UITableView+DequeueCellOfType.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 29.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
    func dequeueCell<T: UITableViewCell>(of type: T.Type,
                                         indexPath: IndexPath) -> T {
        let cellIdentifier = T.className
        let reusableCell = dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        guard let cell = reusableCell as? T else {
            fatalError("Cell has unexpected type")
        }
        return cell
    }
}
