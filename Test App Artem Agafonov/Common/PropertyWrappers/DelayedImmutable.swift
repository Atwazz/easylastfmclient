//
//  DelayedImmutable.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

// seen at
// https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md#delayed-initialization

@propertyWrapper
struct DelayedImmutable<Value> {
    private var _value: Value?
    
    var wrappedValue: Value {
        get {
            guard let value = _value else {
                fatalError("property accessed before being initialized")
            }
            return value
        }
        
        // Perform an initialization, trapping if the
        // value is already initialized.
        set {
            if _value != nil {
                fatalError("property initialized twice")
            }
            _value = newValue
        }
    }
    
    var isInitialized: Bool {
        _value != nil
    }
}
