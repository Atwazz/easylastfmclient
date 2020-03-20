//
//  BaseAssemblerProvider.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 20.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class BaseAssemblerProvider {
    let assembler: Assembler
    
    init(with parentAssembler: Assembler?) {
        let assemblies: [Assembly] = [ApplicationAssembly(),
                                      PersistentStorageAssembly()]
        
        assembler = Assembler(assemblies,
                              parent: parentAssembler)
    }
}
