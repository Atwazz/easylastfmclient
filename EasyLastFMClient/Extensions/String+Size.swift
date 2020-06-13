//
//  String+Size.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.NSStringDrawing

extension String {
    func width(font: UIFont) -> CGFloat {
        size(font: font).width
    }

    func height(font: UIFont) -> CGFloat {
        size(font: font).height
    }

    func size(font: UIFont) -> CGSize {
        size(withAttributes: [.font: font])
    }
}
