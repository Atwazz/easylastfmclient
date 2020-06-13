//
//  Assembler+ResolveViewController.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

extension Assembler {
    func resolveViewController<Service>(_ serviceType: Service.Type) -> UIViewController {
        guard let viewController = synchronizedResolveSafe(serviceType) as? UIViewController else {
            fatalError("Can't resolve UIViewController for type: \(String(describing: serviceType))")
        }
        return viewController
    }
    
    func resolveViewController<Service, Arg1>(_ serviceType: Service.Type, configuration: Arg1) -> UIViewController {
        guard let viewController = synchronizedResolveSafe(serviceType,
                                                           argument: configuration) as? UIViewController else {
            fatalError("Can't resolve UIViewController for type: \(String(describing: serviceType))")
        }
        return viewController
    }
}
