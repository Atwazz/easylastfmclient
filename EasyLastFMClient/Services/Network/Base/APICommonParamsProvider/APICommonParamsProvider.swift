//
//  APICommonParamsProvider.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol APICommonParamsProvider {
    func commonParams(apiMethod: APIMethod) -> APICommonParams
}
