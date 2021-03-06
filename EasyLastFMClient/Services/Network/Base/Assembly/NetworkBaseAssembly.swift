//
//  NetworkBaseAssembly.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class NetworkBaseAssembly { }

// MARK: - Assembly
extension NetworkBaseAssembly: Assembly {
    func assemble(container: Container) {
        registerAPIKeyProvider(in: container)
        registerCommonParamsProvider(in: container)
        registerAPIURLProvider(in: container)
        registerQueueProvider(in: container)
        registerRequestValidator(in: container)
    }
}

// MARK: - Registrations
private extension NetworkBaseAssembly {
    func registerAPIKeyProvider(in container: Container) {
        container.register(APIKeyProvider.self) { _ in
            APIKeyProviderBase()
        }
    }
    
    func registerCommonParamsProvider(in container: Container) {
        container.register(APICommonParamsProvider.self) { resolver in
            let apiKeyProvider = resolver.resolveSafe(APIKeyProvider.self)
            return APICommonParamsProviderBase(apiKeyProvider: apiKeyProvider)
        }
    }
    
    func registerAPIURLProvider(in container: Container) {
        container.register(APIURLProvider.self) { _ in
            APIURLProviderBase()
        }
    }
    
    func registerQueueProvider(in container: Container) {
        container.register(NetworkQueueProvider.self) { _ in
            NetworkQueueProvider()
        }
        .inObjectScope(.container)
    }
    
    func registerRequestValidator(in container: Container) {
        container.register(Validator.self) { resolver in
            let queue = resolver.resolveSafe(NetworkQueueProvider.self).queue
            return RequestValidator(queue: queue)
        }
    }
}
