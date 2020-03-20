//
//  ApplicationStateEmitter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Combine

protocol ApplicationStateEmitter {
    var state: AnyPublisher<ApplicationState, Never> { get }
}
