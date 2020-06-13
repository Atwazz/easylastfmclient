//
//  PersistentStorageLoader.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol PersistentStorageLoader {
    typealias LoadResult = Result<Void, PersistentStorageLoadError>
    
    func load(completion: @escaping (LoadResult) -> Void)
}
