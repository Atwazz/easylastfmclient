//
//  KeyedDecodingContainer+DecodeSafe.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

extension KeyedDecodingContainer {    
    func decodeSafe<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) -> T? {
        do {
            return try decode(type, forKey: key)
        } catch {
            return nil
        }
    }
}
