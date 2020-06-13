//
//  NetworkServicesAssembly.swift
//  Easy Last FM Client
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
        registerAlbumsLoadService(in: container)
        registerAlbumInfoLoadService(in: container)
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
    
    func registerAlbumsLoadService(in container: Container) {
        container.register(ArtistAlbumsLoadService.self) { resolver in
            let queue = resolver.resolveSafe(NetworkQueueProvider.self).queue
            let urlProvider = resolver.resolveSafe(APIURLProvider.self)
            let commonParamsProvider = resolver.resolveSafe(APICommonParamsProvider.self)
            let validator = resolver.resolveSafe(Validator.self)
            return ArtistAlbumsLoadServiceBase(queue: queue,
                                               urlProvider: urlProvider,
                                               commonParamsProvider: commonParamsProvider,
                                               requestValidator: validator)
        }
        .inObjectScope(.weak)
    }
    
    func registerAlbumInfoLoadService(in container: Container) {
        container.register(AlbumInfoLoadService.self) { resolver in
            let queue = resolver.resolveSafe(NetworkQueueProvider.self).queue
            let urlProvider = resolver.resolveSafe(APIURLProvider.self)
            let commonParamsProvider = resolver.resolveSafe(APICommonParamsProvider.self)
            let validator = resolver.resolveSafe(Validator.self)
            return AlbumInfoLoadServiceBase(queue: queue,
                                            urlProvider: urlProvider,
                                            commonParamsProvider: commonParamsProvider,
                                            requestValidator: validator)
        }
        .inObjectScope(.weak)
    }
}
