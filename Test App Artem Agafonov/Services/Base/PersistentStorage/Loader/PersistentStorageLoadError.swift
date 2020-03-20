//
//  PersistentStorageLoadError.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSError

enum PersistentStorageLoadError: Error {
    case loadFailed
    case misuseDetected
}

// MARK: - LocalizedError
extension PersistentStorageLoadError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .loadFailed:
            return "Can't load data from disk. " + errorAdvice
        case .misuseDetected:
            return "Internl error occured. " + errorAdvice
        }
    }
}

// MARK: - Private
private extension PersistentStorageLoadError {
    var errorAdvice: String {
        "Please try reintstalling the app or contact the developer."
    }
}
