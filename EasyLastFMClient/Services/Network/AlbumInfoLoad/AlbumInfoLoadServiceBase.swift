//
//  AlbumInfoLoadServiceBase.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation
import Alamofire

final class AlbumInfoLoadServiceBase {
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

// MARK: - AlbumInfoLoadService
extension AlbumInfoLoadServiceBase: AlbumInfoLoadService {
    func loadAlbumInfo(artist: String,
                       album: String,
                       completion: @escaping (AlbumInfoLoadResult) -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }
            let requestModel = self.requestModel(artist: artist, album: album)
            self.performRequest(requestModel: requestModel,
                                completion: completion)
        }
    }
    
    func loadAlbumInfo(mbid: String,
                       completion: @escaping (AlbumInfoLoadResult) -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }
            let requestModel = self.requestModel(mbid: mbid)
            self.performRequest(requestModel: requestModel,
                                completion: completion)
        }
    }
}

// MARK: - Private
private extension AlbumInfoLoadServiceBase {
    func request(_ model: AlbumInfoLoadRequest) -> DataRequest {
        AF.request(url,
                   method: .get,
                   parameters: model)
    }
    func performRequest(requestModel: AlbumInfoLoadRequest,
                        completion: @escaping (AlbumInfoLoadResult) -> Void) {
        requestValidator.validate(requestModel) { [weak self] validationResult in
            if case let .failure(error) = validationResult {
                completion(.failure(error))
            } else {
                self?.performRequest(validatedRequestModel: requestModel,
                                     completion: completion)
            }
        }
    }
    
    func performRequest(validatedRequestModel: AlbumInfoLoadRequest,
                        completion: @escaping (AlbumInfoLoadResult) -> Void) {
        request(validatedRequestModel)
            .responseDecodable(of: AlbumInfoLoadResponse.self, queue: queue) { response in
                let result = response.result
                    .map { $0.album }
                    .mapError { $0 as Error }
                completion(result)
        }
    }
    
    func requestModel(artist: String? = nil,
                      album: String? = nil,
                      mbid: String? = nil) -> AlbumInfoLoadRequest {
        AlbumInfoLoadRequest(artist: artist,
                             name: album,
                             mbid: mbid,
                             commonParams: commonParameters)
    }
    
    var url: URL {
        urlProvider.apiURL
    }
    
    var commonParameters: APICommonParams {
        commonParamsProvider.commonParams(apiMethod: .albumGetInfo)
    }
}
