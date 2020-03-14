//
//  UIScreen+ScreenSizeProvider.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIScreen

extension UIScreen: ScreenSizeProvider {
    var screenSize: CGSize {
        bounds.size
    }
    
    var screenBounds: CGRect {
        bounds
    }
}
