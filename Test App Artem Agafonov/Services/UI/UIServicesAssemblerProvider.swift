//
//  UIServicesAssemblerProvider.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class UIServicesAssemblerProvider {
    // MARK: - Public instance properties
    let assembler: Assembler
    
    // MARK: - Init
    init(with parent: Assembler?) {
        let assemblies: [Assembly] = [EntryPointAssembly(),
                                      ModuleFactoriesAssembly(),
                                      NavigationAssembly(),
                                      UIHelpersAssembly()]
        assembler = Assembler(assemblies,
                              parent: parent)
    }
}
