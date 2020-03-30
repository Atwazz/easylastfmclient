//
//  ThreadSafe.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation

@propertyWrapper
final class ThreadSafe<Value> {
    private var _value: Value?
    private let _queue: DispatchQueue
    
    init() {
        _value = nil
        _queue = Self.defaultQueue
    }
    
    init(wrappedValue value: Value?, queue: DispatchQueue? = nil) {
        _value = value
        guard let queue = queue else {
            _queue = Self.defaultQueue
            return
        }
        _queue = queue
    }
    
    var wrappedValue: Value? {
        get {
            return _queue.sync { [weak self] in
                return self?._value
            }
        }
        set {
            _queue.async(flags: .barrier) { [weak self] in
                self?._value = newValue
            }
        }
    }
}

// MARK: - Private
private extension ThreadSafe {
    static var defaultQueue: DispatchQueue {
        DispatchQueue(label: UUID().uuidString,
                      qos: .userInteractive,
                      attributes: .concurrent)
    }
}
