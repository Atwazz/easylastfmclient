//
//  ScreenSizeProvider.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreGraphics.CGGeometry

protocol ScreenSizeProvider {
    var screenSize: CGSize { get }
    var screenBounds: CGRect { get }
}
