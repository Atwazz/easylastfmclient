//
//  NetworkServicesAssemblerProvider.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class NetworkServicesAssemblerProvider {
    // MARK: - Public instance properties
    let assembler: Assembler
    
    // MARK: - Init
    init(with parent: Assembler?) {
        let assemblies: [Assembly] = [NetworkBaseAssembly(),
                                      NetworkServicesAssembly()]
        assembler = Assembler(assemblies,
                              parent: parent)
    }
}
