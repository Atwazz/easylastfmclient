//
//  KeyedDecodingContainer+DecodeUIntFromString.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

extension KeyedDecodingContainer {
    func decodeUIntFromString(forKey key: KeyedDecodingContainer<K>.Key) -> UInt {
        guard let stringValue = decodeSafe(String.self, forKey: key),
            let uintValue = UInt(stringValue) else {
            assertionFailure("Can't decode UInt for key: \(key)")
            return 0
        }
        return uintValue
    }
}
