//
//  Assembler+SynchronizedResolver.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

extension Assembler {
    var synchronizedResolver: Resolver {
        resolver.synchronized
    }
    
    func synchronizedResolveSafe<Service>(_ serviceType: Service.Type,
                                          name: String? = nil) -> Service {
        synchronizedResolver.resolveSafe(serviceType)
    }
    
    func resolveViewController<Service>(_ serviceType: Service.Type) -> UIViewController {
        guard let viewController = synchronizedResolveSafe(serviceType) as? UIViewController else {
            fatalError("Can't resolve UIViewController for type: \(String(describing: serviceType))")
        }
        return viewController
    }
}
