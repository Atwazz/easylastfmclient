//
//  PersistentStorageState.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 20.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

enum PersistentStorageState {
    case unknown
    case loaded
    case loadFailed(error: PersistentStorageLoadError)
}

// MARK: - Equatable
extension PersistentStorageState: Equatable {
    static func == (lhs: PersistentStorageState, rhs: PersistentStorageState) -> Bool {
        switch (lhs, rhs) {
        case (.unknown,
              .unknown):
            return true
        case (.loaded,
              .loaded):
            return true
        case let (.loadFailed(lhsError),
                  .loadFailed(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
