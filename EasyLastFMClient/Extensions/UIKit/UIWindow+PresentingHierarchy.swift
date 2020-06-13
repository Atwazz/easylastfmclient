//
//  UIWindow+PresentingHierarchy.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIWindow

extension UIWindow {
    var presentingHierarchy: [UIViewController]? {
        guard let rootViewController = rootViewController else {
            return nil
        }
        
        var topPresentedViewController = rootViewController
        while let presentedViewController = topPresentedViewController.presentedViewController {
            topPresentedViewController = presentedViewController
        }
        
        var hierarchy: [UIViewController] = [topPresentedViewController]
        while let presentingViewController = hierarchy.first?.presentingViewController {
            hierarchy.insert(presentingViewController, at: 0)
        }
        
        return hierarchy
    }
}
