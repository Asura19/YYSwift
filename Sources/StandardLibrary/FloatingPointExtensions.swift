//
//  FloatingPointExtensions.swift
//  YYKitBase
//
//  Created by Phoenix on 2017/11/29.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension FloatingPoint {
    
    public var abs: Self {
        return Swift.abs(self)
    }
    
    public var isPositive: Bool {
        return self > 0
    }
    
    public var isNegative: Bool {
        return self < 0
    }
    
    public var ceil: Self {
        return Foundation.ceil(self)
    }
    
    public var degreesToRadians: Self {
        return Self.pi * self / Self(180)
    }
    
    public var radiansToDegrees: Self {
        return self * Self(180) / Self.pi
    }
}

public extension FloatingPoint {

    public static func random(between min: Self, and max: Self) -> Self {
        let aMin = Self.minimum(min, max)
        let aMax = Self.maximum(min, max)
        let delta = aMax - aMin
        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
    }
    
    public static func random(inRange range: ClosedRange<Self>) -> Self {
        let delta = range.upperBound - range.lowerBound
        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
    }
}

public extension FloatingPoint {
    
    public init(randomBetween min: Self, and max: Self) {
        let aMin = Self.minimum(min, max)
        let aMax = Self.maximum(min, max)
        let delta = aMax - aMin
        self = Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
    }
    
    public init(randomInRange range: ClosedRange<Self>) {
        let delta = range.upperBound - range.lowerBound
        self = Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
    }
    
}




prefix operator ±
public prefix func ±<T: FloatingPoint> (number: T) -> (T, T) {
    return (0 + number, 0 - number)
}
