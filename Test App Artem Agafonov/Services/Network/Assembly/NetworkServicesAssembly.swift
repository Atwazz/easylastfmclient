//
//  NetworkServicesAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject

final class NetworkServicesAssembly { }

// MARK: - Assembly
extension NetworkServicesAssembly: Assembly {
    func assemble(container: Container) {
        registerAPIKeyProvider(in: container)
    }
}

// MARK: - Registrations
private extension NetworkServicesAssembly {
    func registerAPIKeyProvider(in container: Container) {
        container.register(APIKeyProvider.self) { _ in
            APIKeyProviderBase()
        }
    }
}
