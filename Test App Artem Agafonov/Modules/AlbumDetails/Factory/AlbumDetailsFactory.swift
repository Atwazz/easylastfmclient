//
//  AlbumDetailsFactory.swift
//  Test App Artem Agafonov
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

// MARK: - ScreenFactory
extension AlbumDetailsFactory: ScreenFactory {
    var viewController: UIViewController {
        screenAssembler.resolveViewController(AlbumDetailsViewInput.self)
    }
}
