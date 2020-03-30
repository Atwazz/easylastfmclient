//
//  UITableView+DeselectAllRows.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
    func deselectAllRows(animated: Bool = false) {
        guard let selectedIndexPaths = indexPathsForSelectedRows else {
            return
        }
        selectedIndexPaths.forEach { deselectRow(at: $0, animated: animated) }
    }
}
