//
//  RequestValidator.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation

struct RequestValidator {
    // MARK: - Private instance properties
    let queue: DispatchQueue
}

// MARK: - Validator
extension RequestValidator: Validator {
    func validate(_ validatable: Validatable,
                  completion: @escaping (ValidationResult) -> Void) {
        queue.async {
            guard validatable.isValid() else {
                completion(.failure(RequestValidationError.requestModelIsInvalid))
                return
            }
            completion(.success)
        }
    }
}
