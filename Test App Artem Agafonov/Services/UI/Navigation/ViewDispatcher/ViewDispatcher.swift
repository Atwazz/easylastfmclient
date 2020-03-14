//
//  ViewDispatcher.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIViewController

protocol ViewDispatcher {
    func show(rootViewController: UIViewController)
    func push(_ viewController: UIViewController)
    func presentModal(_ viewController: UIViewController, completion: (() -> Void)?)
    func dismissTopViewController(completion: (() -> Void)?)
}

extension ViewDispatcher {
    func presentModal(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        presentModal(viewController, completion: completion)
    }
    
    func dismissTopViewController(completion: (() -> Void)? = nil) {
        dismissTopViewController(completion: nil)
    }
}