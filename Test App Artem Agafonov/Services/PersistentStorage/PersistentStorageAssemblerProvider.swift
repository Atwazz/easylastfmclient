//
//  PersistentStorageAssemblerProvider.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class PersistentStorageAssemblerProvider {
    let assembler: Assembler
    
    init(with parentAssembler: Assembler?) {
        let assemblies: [Assembly] = [PersistentStorageHelpersAssembly(),
                                      PersistentStorageMaintanenceAssembly()]
        
        assembler = Assembler(assemblies,
                              parent: parentAssembler)
    }
}
