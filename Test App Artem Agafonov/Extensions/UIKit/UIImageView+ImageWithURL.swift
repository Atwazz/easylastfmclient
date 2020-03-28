//
//  UIImageView+ImageWithURL.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIImageView
import AlamofireImage

extension UIImageView {
    func setImage(with url: URL?, placeholderName: String) {
        if let imageUrl = url {
            af.setImage(withURL: imageUrl)
        } else {
            image = UIImage(named: placeholderName)
        }
    }
}
