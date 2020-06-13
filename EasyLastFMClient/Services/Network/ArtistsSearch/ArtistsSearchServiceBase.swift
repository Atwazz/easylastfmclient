//
//  ArtistsSearchServiceBase.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation
import Alamofire

final class ArtistsSearchServiceBase {
    // MARK: - Private instance properties
    private let urlProvider: APIURLProvider
    private let commonParamsProvider: APICommonParamsProvider
    private let queue: DispatchQueue
    
    // MARK: - Init
    init(queue: DispatchQueue,
         urlProvider: APIURLProvider,
         commonParamsProvider: APICommonParamsProvider) {
        self.queue = queue
        self.commonParamsProvider = commonParamsProvider
        self.urlProvider = urlProvider
    }
}

// MARK: - ArtistsSearchService
extension ArtistsSearchServiceBase: ArtistsSearchService {
    func search(for artist: String,
                page: UInt?,
                pageSize: UInt?,
                completion: @escaping (ArtistsSearchResult) -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }
            self.request(for: artist, page: page, pageSize: pageSize)
                .responseDecodable(of: ArtistsSearchResponse.self, queue: self.queue) { response in
                    let result = response.result
                        .map { $0.results }
                        .mapError { $0 as Error }
                    completion(result)
            }
        }
        
    }
}

// MARK: - Private
private extension ArtistsSearchServiceBase {
    func request(for artist: String,
                 page: UInt?,
                 pageSize: UInt?) -> DataRequest {
        let parameters = requestModel(for: artist,
                                      page: page,
                                      pageSize: pageSize)
        return AF.request(url,
                          method: .get,
                          parameters: parameters)
    }
    
    func requestModel(for artist: String,
                      page: UInt?,
                      pageSize: UInt?) -> ArtistsSearchRequest {
        ArtistsSearchRequest(artist: artist,
                             page: page,
                             limit: pageSize,
                             commonParams: commonParameters)
    }
    
    var url: URL {
        urlProvider.apiURL
    }
    
    var commonParameters: APICommonParams {
        commonParamsProvider.commonParams(apiMethod: .artistsSearch)
    }
}
