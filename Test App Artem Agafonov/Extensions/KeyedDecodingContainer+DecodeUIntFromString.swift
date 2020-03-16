//
//  KeyedDecodingContainer+decodeUIntFromString.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

extension KeyedDecodingContainer {
    func decodeUIntFromString(forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt {
        let stringValue = try decode(String.self, forKey: key)
        guard let uintValue = UInt(stringValue) else {
            assertionFailure("Can't decode UInt for key: \(key)")
            return 0
        }
        return uintValue
    }
}
