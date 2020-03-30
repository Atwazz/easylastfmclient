//
//  UITableView+FooterLoadingIndicator.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
    func setupFooterLoadingIndicator() {
        let footerSpinner = UIActivityIndicatorView(style: .medium)
        footerSpinner.startAnimating()
        tableFooterView = footerSpinner
        hideFooter()
    }
    
    func showFooter() {
        tableFooterView?.isHidden = false
    }
    
    func hideFooter() {
        tableFooterView?.isHidden = true
    }
}
