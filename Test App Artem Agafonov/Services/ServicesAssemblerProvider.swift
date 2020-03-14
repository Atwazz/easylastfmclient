//
//  ServicesAssemblerProvider.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class ServicesAssemblerProvider {
    // MARK: - Private instance properties
    private var emptyAssembler: Assembler = {
        Assembler([], container: Container())
    }()

    private lazy var uiServicesAssembler: Assembler = {
        let uiServicesAssemblerProvider = UIServicesAssemblerProvider(with: emptyAssembler)
        return uiServicesAssemblerProvider.assembler
    }()

    // MARK: - Public properties
    private(set) lazy var assembler: Assembler = {
        uiServicesAssembler
    }()
    
    static let instance = ServicesAssemblerProvider()
}
