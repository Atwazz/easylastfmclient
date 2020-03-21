//
//  NSObject+DefaulttNib.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 22.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UINib

extension NSObject {
    static var defaultNib: UINib {
        UINib.init(nibName: self.className, bundle: nil)
    }
}
