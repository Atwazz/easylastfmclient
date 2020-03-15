//
//  APICommonParamsProvider.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol APICommonParamsProvider {
    func commonParams(apiMethod: APIMethod) -> APICommonParams
}
