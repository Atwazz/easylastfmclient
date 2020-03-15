//
//  DisposeBag.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Combine

typealias DisposeBag = [AnyCancellable]

extension Array where Element: AnyCancellable {
    mutating func dispose() {
        forEach { $0.cancel() }
        removeAll()
    }
}
