//
//  ModuleFactoriesAssembly.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class ModuleFactoriesAssembly: Assembly {
    // MARK: - Assembly
    func assemble(container: Container) {
        registerMainScreenFactory(in: container)
        registerArtistsSearchFactory(in: container)
        registerAlbumDetailsFactory(in: container)
        registerAlbumsScreenFactory(in: container)
    }
}

// MARK: - Private - Register
private extension ModuleFactoriesAssembly {
    func registerMainScreenFactory(in container: Container) {
        container.register(MainScreenFactory.self) { _ in
            MainScreenFactory(parentAssembler: Self.servicesAssembler)
        }
    }
    
    func registerArtistsSearchFactory(in container: Container) {
        container.register(ArtistsSearchFactory.self) { _ in
            ArtistsSearchFactory(parentAssembler: Self.servicesAssembler)
        }
    }
    
    func registerAlbumDetailsFactory(in container: Container) {
        container.register(AlbumDetailsFactory.self) { _ in
            AlbumDetailsFactory(parentAssembler: Self.servicesAssembler)
        }
    }
    
    func registerAlbumsScreenFactory(in container: Container) {
        container.register(AlbumsScreenFactory.self) { _ in
            AlbumsScreenFactory(parentAssembler: Self.servicesAssembler)
        }
    }
}

// MARK: - Private
private extension ModuleFactoriesAssembly {
    static var servicesAssembler: Assembler {
        ServicesAssemblerProvider.instance.assembler
    }
}
