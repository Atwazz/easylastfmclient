//
//  ViewDispatcherBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIWindow
import UIKit.UIViewController

final class ViewDispatcherBase {
    // MARK: - Private instance properties
    private let window: UIWindow
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - ViewDispatcher
extension ViewDispatcherBase: ViewDispatcher {
    func show(rootViewController: UIViewController) {
        window.makeKeyAndVisible()
        window.rootViewController = wrappedViewControllerInNavigation(rootViewController)
    }
    
    func push(_ viewController: UIViewController) {
        guard let navigationController = topViewController as? UINavigationController else {
            fatalError("ViewDispatcher misuse detected")
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentModal(_ viewController: UIViewController, completion: (() -> Void)?) {
        guard let topViewController = topViewController else {
            fatalError("ViewDispatcher misuse detected")
        }
        topViewController.present(viewController,
                                  animated: true,
                                  completion: completion)
    }
    
    func dismissTopViewController(completion: (() -> Void)?) {
        guard let viewController = topViewController,
            viewController.presentingViewController != nil else {
                return
        }
        viewController.dismiss(animated: true, completion: completion)
    }
}

// MARK: - Private
private extension ViewDispatcherBase {
    var topViewController: UIViewController? {
        window.presentingHierarchy?.reverseFind { !$0.isBeingDismissed }
    }
    
    func wrappedViewControllerInNavigation(_ viewController: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: viewController)
    }
}
