//
//  BaseAssemblerProvider.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 20.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class BaseAssemblerProvider {
    let assembler: Assembler
    
    init(with parentAssembler: Assembler?) {
        let assemblies: [Assembly] = [ApplicationAssembly()]
        
        assembler = Assembler(assemblies,
                              parent: parentAssembler)
    }
}
