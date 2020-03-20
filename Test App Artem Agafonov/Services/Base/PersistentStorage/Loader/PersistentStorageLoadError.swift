//
//  PersistentStorageLoadError.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

enum PersistentStorageLoadError: Error {
    case loadFailed
    case misuseDetected
}

// MARK: - Public
extension PersistentStorageLoadError {
    var localizedDescription: String {
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
        "Please try reintstall the app or contact the developer."
    }
}
