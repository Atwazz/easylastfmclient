//
//  NetworkServicesAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class NetworkServicesAssembly { }

// MARK: - Assembly
extension NetworkServicesAssembly: Assembly {
    func assemble(container: Container) {
       registerArtistsSearchService(in: container)
    }
}

// MARK: - Registrations
private extension NetworkServicesAssembly {
    func registerArtistsSearchService(in container: Container) {
        container.register(ArtistsSearchService.self) { resolver in
            let queue = resolver.resolveSafe(NetworkQueueProvider.self).queue
            let urlProvider = resolver.resolveSafe(APIURLProvider.self)
            let commonParamsProvider = resolver.resolveSafe(APICommonParamsProvider.self)
            return ArtistsSearchServiceBase(queue: queue,
                                            urlProvider: urlProvider,
                                            commonParamsProvider: commonParamsProvider)
        }
        .inObjectScope(.weak)
    }
}
