//
//  NSSet+Convenience.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSSet

extension NSSet {
    func set<T: Hashable>(of type: T.Type) -> Set<T>? {
        self as? Set<T>
    }
    
    func array<T: Hashable>(of type: T.Type) -> [T]? {
        guard let typedSet = set(of: type) else {
            return nil
        }
        return Array(typedSet)
    }
}
