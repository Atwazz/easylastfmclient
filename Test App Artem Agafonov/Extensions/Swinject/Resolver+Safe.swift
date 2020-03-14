//
//  Resolver+Safe.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

extension Resolver {
    var synchronized: Resolver {
        guard let container = self as? Container else {
            fatalError("Cannot resolve the Resolver as a Container")
        }
        return container.synchronize()
    }
    
    func resolveSafe<Service>(_ serviceType: Service.Type, name: String? = nil) -> Service {
        guard let instance = resolve(serviceType, name: name) else {
            var errorDescription = "\(#function) -> Can't resolve \(String(describing: serviceType))"
            if let name = name {
                errorDescription.append(" named \(name)")
            }
            fatalError(errorDescription)
        }
        return instance
    }
}
