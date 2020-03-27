//
//  ConfiguredScreenFactory.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 27.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIViewController

protocol ConfiguredScreenFactory {
    associatedtype Configuration
    
    func viewController(configuration: Configuration) -> UIViewController
}
