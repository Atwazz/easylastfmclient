//
//  NetworkQueueProvider.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation

final class NetworkQueueProvider {
    let queue = DispatchQueue(label: "com.agafonov.network.queue",
                              qos: .default)
}
