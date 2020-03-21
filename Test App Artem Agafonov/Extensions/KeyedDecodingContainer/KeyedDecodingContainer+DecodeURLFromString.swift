//
//  KeyedDecodingContainer+DecodeURLFromString.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

extension KeyedDecodingContainer {
    func decodeURLFromString(forKey key: KeyedDecodingContainer<K>.Key) -> URL? {
        guard let stringValue = decodeSafe(String.self, forKey: key) else {
            return nil
        }
        guard stringValue.count > 0,
            let url = URL(string: stringValue) else {
                return nil
        }
        return url
    }
}
