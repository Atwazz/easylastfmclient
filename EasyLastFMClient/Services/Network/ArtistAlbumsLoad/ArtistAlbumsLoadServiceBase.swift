//
//  ArtistAlbumsLoadServiceBase.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation
import Alamofire

final class ArtistAlbumsLoadServiceBase {
    // MARK: - Private instance properties
    private let urlProvider: APIURLProvider
    private let commonParamsProvider: APICommonParamsProvider
    private let queue: DispatchQueue
    private let requestValidator: Validator
    
    // MARK: - Init
    init(queue: DispatchQueue,
         urlProvider: APIURLProvider,
         commonParamsProvider: APICommonParamsProvider,
         requestValidator: Validator) {
        self.queue = queue
        self.commonParamsProvider = commonParamsProvider
        self.urlProvider = urlProvider
        self.requestValidator = requestValidator
    }
}

// MARK: - ArtistAlbumsLoadService
extension ArtistAlbumsLoadServiceBase: ArtistAlbumsLoadService {
    func loadAlbums(artistName: String,
                    page: UInt?,
                    pageSize: UInt?,
                    completion: @escaping (AlbumsLoadResult) -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }
            let requestModel = self.requestModel(artistName: artistName,
                                                 page: page,
                                                 pageSize: pageSize)
            self.performRequest(requestModel: requestModel,
                                completion: completion)
            
        }
    }
    
    func loadAlbums(artistMbid: String,
                    page: UInt?,
                    pageSize: UInt?,
                    completion: @escaping (AlbumsLoadResult) -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }
            let requestModel = self.requestModel(artistMbid: artistMbid,
                                                 page: page,
                                                 pageSize: pageSize)
            self.performRequest(requestModel: requestModel,
                                completion: completion)
            
        }
    }
}

// MARK: - Private
private extension ArtistAlbumsLoadServiceBase {
    func request(_ model: ArtistAlbumsLoadRequest) -> DataRequest {
        AF.request(url,
                   method: .get,
                   parameters: model)
    }
    func performRequest(requestModel: ArtistAlbumsLoadRequest,
                        completion: @escaping (AlbumsLoadResult) -> Void) {
        requestValidator.validate(requestModel) { [weak self] validationResult in
            if case let .failure(error) = validationResult {
                completion(.failure(error))
            } else {
                self?.performRequest(validatedRequestModel: requestModel,
                                     completion: completion)
            }
        }
    }
    
    func performRequest(validatedRequestModel: ArtistAlbumsLoadRequest,
                        completion: @escaping (AlbumsLoadResult) -> Void) {
        request(validatedRequestModel)
            .responseDecodable(of: ArtistAlbumsLoadResponse.self, queue: queue) { response in
                let result = response.result
                    .map { $0.results }
                    .mapError { $0 as Error }
                completion(result)
        }
    }
    
    func requestModel(artistName: String? = nil,
                      artistMbid: String? = nil,
                      page: UInt?,
                      pageSize: UInt?) -> ArtistAlbumsLoadRequest {
        ArtistAlbumsLoadRequest(artistName: artistName,
                                artistMbid: artistMbid,
                                page: page,
                                limit: pageSize,
                                commonParams: commonParameters)
    }
    
    var url: URL {
        urlProvider.apiURL
    }
    
    var commonParameters: APICommonParams {
        commonParamsProvider.commonParams(apiMethod: .artistsGetTopAlbums)
    }
}
