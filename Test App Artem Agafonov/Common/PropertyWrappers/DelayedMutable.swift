//
//  DelayedMutable.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

// seen at
// https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md#delayed-initialization

@propertyWrapper
struct DelayedMutable<Value> {
    private var _value: Value?
    
    init() {
        _value = nil
    }
    
    var wrappedValue: Value {
        get {
            guard let value = _value else {
                fatalError("property accessed before being initialized")
            }
            return value
        }
        set {
            _value = newValue
        }
    }
    
    var isInitialized: Bool {
        _value != nil
    }
    
    /// "Reset" the wrapper so it can be initialized again.
    mutating func reset() {
        _value = nil
    }
}
