//
//  UIImageView+ImageWithURL.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIImageView
import AlamofireImage

extension UIImageView {
    func setImage(with url: URL?, placeholderName: String) {
        image = UIImage(named: placeholderName)
        if let imageUrl = url {
            af.setImage(withURL: imageUrl)
        }
    }
}
