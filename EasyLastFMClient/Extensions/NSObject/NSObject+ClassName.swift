//
//  NSObject+ClassName.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSObject

@objc extension NSObject {
    final var className: String {
        return type(of: self).className
    }
    
    static var className: String {
        let classWithModuleAndGenericQuotes = NSStringFromClass(self)
        guard let classNameWithGenericQuotes = classWithModuleAndGenericQuotes.components(separatedBy: ".").last,
            let className = classNameWithGenericQuotes.components(separatedBy: "<").first else {
                fatalError("Bad className for class: \(self)")
        }
        return className
    }
}
