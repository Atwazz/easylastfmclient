//
//  APIURLProviderBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

final class APIURLProviderBase: APIURLProvider {
    // MARK: - Private static properties
    private static let apiScheme = "https"
    private static let apiVersion = "2.0"
    private static let apiHost = "ws.audioscrobbler.com"
    
    // MARK: - APIURLProvider
    lazy var apiURL: URL = {
        guard let url = urlComponents.url else {
            fatalError("Can't resolve API URL from the components")
        }
        return url
    }()
}

// MARK: - Private
private extension APIURLProviderBase {
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = Self.apiScheme
        components.host = Self.apiHost
        components.path = "/\(Self.apiVersion)/"
        return components
    }
}
