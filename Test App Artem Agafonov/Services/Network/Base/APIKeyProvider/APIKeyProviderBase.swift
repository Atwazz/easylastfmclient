//
//  APIKeyProviderBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct APIKeyProviderBase {
    static let key = "4679af1bef03ba2366477f09a931efc8"
    static let secret = "ae79602fb93054c6c49b48904362a10a"
}

// MARK: - APIKeyProvider
extension APIKeyProviderBase: APIKeyProvider {
    var apiKey: String {
        Self.key
    }
    
    var sharedSecret: String {
        Self.secret
    }
}
