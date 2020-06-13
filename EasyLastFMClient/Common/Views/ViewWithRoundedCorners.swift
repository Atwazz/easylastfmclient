//
//  ViewWithRoundedCorners.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIView

@IBDesignable final class ViewWithRoundedCorners: UIView {
    // MARK: - Private instance properties
    private var roundingRadius: CGFloat = 0 {
        didSet { updateMask() }
    }
    
    // MARK: - IBInspectable
    @IBInspectable var cornerRadius: CGFloat {
        get { return roundingRadius }
        set { roundingRadius = max(0, newValue) }
    }
    
    @IBInspectable var roundTopLeftCorner: Bool = false {
        didSet { updateMask() }
    }
    
    @IBInspectable var roundTopRightCorner: Bool = false {
        didSet { updateMask() }
    }
    
    @IBInspectable var roundBottomLeftCorner: Bool = false {
        didSet { updateMask() }
    }
    
    @IBInspectable var roundBottomRightCorner: Bool = false {
        didSet { updateMask() }
    }
}

// MARK: - Private
private extension ViewWithRoundedCorners {
    var noCornersRounded: Bool {
        !(roundTopLeftCorner || roundTopRightCorner || roundBottomLeftCorner || roundBottomRightCorner)
    }
    
    func updateMask() {
        clipsToBounds = true
        
        guard !noCornersRounded, cornerRadius > 0 else {
            layer.cornerRadius = 0
            layer.maskedCorners = []
            return
        }
        
        layer.cornerRadius = cornerRadius
        var maskedCorners: CACornerMask = []
        
        if roundTopLeftCorner {
            maskedCorners.insert(.layerMinXMinYCorner)
        }
        if roundTopRightCorner {
            maskedCorners.insert(.layerMaxXMinYCorner)
        }
        if roundBottomLeftCorner {
            maskedCorners.insert(.layerMinXMaxYCorner)
        }
        if roundBottomRightCorner {
            maskedCorners.insert(.layerMaxXMaxYCorner)
        }
        
        layer.maskedCorners = maskedCorners
    }
}
