//
//  ArtistsSearchFactory.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class ArtistsSearchFactory {
    // MARK: - Private instance properties
    private let screenAssembler: Assembler
    
    // MARK: - Init
    init(parentAssembler: Assembler?) {
        screenAssembler = Assembler([ArtistsSearchAssembly()],
                                    parent: parentAssembler)
    }
}

// MARK: - ScreenFactory
extension ArtistsSearchFactory: ScreenFactory {
    var viewController: UIViewController {
        screenAssembler.resolveViewController(ArtistsSearchViewInput.self)
    }
}
