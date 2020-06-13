//
//  AlbumDetailsFactory.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class AlbumDetailsFactory {
    // MARK: - Private instance properties
    private let screenAssembler: Assembler
    
    // MARK: - Init
    init(parentAssembler: Assembler?) {
        screenAssembler = Assembler([AlbumDetailsAssembly()],
                                    parent: parentAssembler)
    }
}

// MARK: - ConfiguredScreenFactory
extension AlbumDetailsFactory: ConfiguredScreenFactory {
    typealias Configuration = AlbumDetailsConfiguration
    
    func viewController(configuration: Configuration) -> UIViewController {
        screenAssembler.resolveViewController(AlbumDetailsViewInput.self,
                                              configuration: configuration)
    }
}
