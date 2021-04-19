//
//  ThreadSafe.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation

@propertyWrapper
final class ThreadSafe<Value> {
	// MARK: Private instance properties
	private var _value: Value
	private let _queue: DispatchQueue

	// MARK: Init
	init(wrappedValue value: Value, queue: DispatchQueue? = nil) {
		_value = value
		_queue = queue ?? Self.defaultQueue
	}

	var wrappedValue: Value {
		get {
			_queue.sync {
				return self._value
			}
		}
		set {
			_queue.async(flags: .barrier) { [weak self] in
				self?._value = newValue
			}
		}
	}
}

// MARK: - Public
extension ThreadSafe {
	func mutate(_ mutation: (inout Value) -> Void) {
		_queue.sync {
			mutation(&_value)
		}
	}
}

// MARK: - Private
private extension ThreadSafe {
	static var defaultQueue: DispatchQueue {
		DispatchQueue(
			label: UUID().uuidString,
			qos: .userInteractive,
			attributes: .concurrent
		)
	}
}
