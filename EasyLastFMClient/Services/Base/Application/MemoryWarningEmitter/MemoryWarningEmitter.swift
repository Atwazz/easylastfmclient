//
//  MemoryWarningEmitter.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Combine

protocol MemoryWarningEmitter {
    var memoryWarning: AnyPublisher<Void, Never> { get }
}
