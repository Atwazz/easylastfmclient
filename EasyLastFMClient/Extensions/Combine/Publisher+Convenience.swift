//
//  Publisher+Convenience.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 20.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation
import Combine

extension Publisher where Self.Failure == Never {
    func sink(on queue: DispatchQueue,
              receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        sink { value in
            queue.async {
                receiveValue(value)
            }
        }
    }
}
