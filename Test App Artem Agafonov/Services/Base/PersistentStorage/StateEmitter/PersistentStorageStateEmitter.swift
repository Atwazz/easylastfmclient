//
//  PersistentStorageStateEmitter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 20.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Combine

protocol PersistentStorageStateEmitter {
    var state: AnyPublisher<PersistentStorageState, Never> { get }
}
