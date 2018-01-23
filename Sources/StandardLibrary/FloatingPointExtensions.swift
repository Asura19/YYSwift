//
//  FloatingPointExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/11/29.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

// MARK: - Properties
public extension FloatingPoint {
    
    /// YYSwift: Absolute value of integer number.
    public var abs: Self {
        return Swift.abs(self)
    }
    
    /// YYSwift: Check if integer is positive.
    public var isPositive: Bool {
        return self > 0
    }
    
    /// YYSwift: Check if integer is negative.
    public var isNegative: Bool {
        return self < 0
    }
    
    /// YYSwift: Ceil of number.
    public var ceil: Self {
        return Foundation.ceil(self)
    }
    
    /// YYSwift: Floor of number.
    public var floor: Self {
        return Foundation.floor(self)
    }
    
    /// YYSwift: Radian value of degree input.
    public var degreesToRadians: Self {
        return Self.pi * self / Self(180)
    }
    
    /// YYSwift: Degree value of radian input.
    public var radiansToDegrees: Self {
        return self * Self(180) / Self.pi
    }
}

public extension FloatingPoint {

    /// YYSwift: Random number between two number.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    /// - Returns: random number between two numbers.
    public static func random(between min: Self, and max: Self) -> Self {
        let aMin = Self.minimum(min, max)
        let aMax = Self.maximum(min, max)
        let delta = aMax - aMin
        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
    }
    
    /// YYSwift: Random number in a closed interval range.
    ///
    /// - Parameter range: closed interval range.
    /// - Returns: random number in the given closed range.
    public static func random(inRange range: ClosedRange<Self>) -> Self {
        let delta = range.upperBound - range.lowerBound
        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
    }
}

public extension FloatingPoint {
    
    /// YYSwift: Created a random number between two numbers.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    public init(randomBetween min: Self, and max: Self) {
        let aMin = Self.minimum(min, max)
        let aMax = Self.maximum(min, max)
        let delta = aMax - aMin
        self = Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
    }
    
    /// YYSwift: Create a random number in a closed interval range.
    ///
    /// - Parameter range: closed interval range.
    public init(randomInRange range: ClosedRange<Self>) {
        let delta = range.upperBound - range.lowerBound
        self = Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
    }
    
}


prefix operator ±
/// YYSwift: Tuple of plus-minus operation.
///
/// - Parameter int: number
/// - Returns: tuple of plus-minus operation (± 2.5 -> (2.5, -2.5)).
public prefix func ±<T: FloatingPoint> (number: T) -> (T, T) {
    return (0 + number, 0 - number)
}
