//
//  Time.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSDate

struct Time {
    // MARK: - Private instance properties
    private let totalSeconds: UInt32
    
    // MARK: - Public instance properties
    private(set) var days: UInt32 = 0
    private(set) var hours: UInt32 = 0
    private(set) var minutes: UInt32 = 0
    private(set) var seconds: UInt32 = 0
    
    // MARK: - Init
    init(seconds: UInt32) {
        totalSeconds = seconds
        update()
    }
}

// MARK: - Public
extension Time {
    func formattedString(_ delimeter: String = ":") -> String {
        let hoursString = hours > 0 ? hours.twoDigitsString : ""
        let minuteString = minutes.twoDigitsString
        let secondsString = seconds.twoDigitsString
        return hoursString + (hoursString.count > 0 ? delimeter : "") +
            minuteString + delimeter +
            secondsString
    }
}

// MARK: - Private
private extension Time {
    mutating func update() {
        seconds = totalSeconds.seconds
        minutes = totalSeconds.minutes
        hours = totalSeconds.hours
        days = totalSeconds.days
    }
}

// MARK: - UInt32 + Formatting
private extension UInt32 {
    var seconds: UInt32 {
        self % Self.secondsInMinute
    }
    
    var minutes: UInt32 {
        (self / Self.secondsInMinute) % Self.minutesInHour
    }
    
    var hours: UInt32 {
        (self / Self.secondsInHour) % Self.hoursInDay
    }
    
    var days: UInt32 {
        (self / Self.secondsInDay)
    }
    
    var twoDigitsString: String {
        self < 10 ? "0" + String(self) : String(self)
    }
}

// MARK: - UInt32 + Constants
private extension UInt32 {
    static let secondsInMinute: UInt32 = 60
    static let minutesInHour: UInt32 = 60
    static let hoursInDay: UInt32 = 24
    static let secondsInHour = secondsInMinute * minutesInHour
    static var secondsInDay = secondsInHour * hoursInDay
}
