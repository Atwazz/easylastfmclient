//
//  UIApplication+URLHandler.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 29.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIApplication

extension UIApplication: URLHandler {
    func open(url: URL) {
        open(url, options: [:])
    }
}
