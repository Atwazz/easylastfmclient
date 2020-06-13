//
//  AlbumsScreenFactory.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class AlbumsScreenFactory {
    // MARK: - Private instance properties
    private let screenAssembler: Assembler
    
    // MARK: - Init
    init(parentAssembler: Assembler?) {
        screenAssembler = Assembler([AlbumsScreenAssembly()],
                                    parent: parentAssembler)
    }
}

// MARK: - ConfiguredScreenFactory
extension AlbumsScreenFactory: ConfiguredScreenFactory {
    typealias Configuration = AlbumsScreenConfiguration
    
    func viewController(configuration: Configuration) -> UIViewController {
        screenAssembler.resolveViewController(AlbumsScreenViewInput.self,
                                              configuration: configuration)
    }
}
