//
//  Validator.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 16.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol Validator {
    typealias ValidationResult = Result<Void, Error>
    
    func validate(_ validatable: Validatable,
                  completion: @escaping (ValidationResult) -> Void)
}
