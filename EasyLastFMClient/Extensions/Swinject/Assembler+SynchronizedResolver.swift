//
//  Assembler+SynchronizedResolver.swift
//  Easy Last FM Client
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
    
    func synchronizedResolveSafe<Service, Arg1>(_ serviceType: Service.Type,
                                                argument: Arg1) -> Service {
        synchronizedResolver.resolveSafe(serviceType, argument: argument)
    }
}
