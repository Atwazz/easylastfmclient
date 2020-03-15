//
//  APICommonParamsProviderBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct APICommonParamsProviderBase {
    // MARK: - Private instance properties
    private let apiKeyProvider: APIKeyProvider
    
    // MARK: - Init
    init(apiKeyProvider: APIKeyProvider) {
        self.apiKeyProvider = apiKeyProvider
    }
}

// MARK: - APICommonParamsProvide
extension APICommonParamsProviderBase: APICommonParamsProvider {
    func commonParams(apiMethod: APIMethod) -> APICommonParams {
        APICommonParamsBase(method: apiMethod,
                            apiKey: apiKeyProvider.apiKey)
    }
}
