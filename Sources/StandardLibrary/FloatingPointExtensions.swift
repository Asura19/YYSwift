//
//  FloatingPointExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/11/29.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties
public extension FloatingPoint {
    
    /// YYSwift: Absolute value of integer number.
    var abs: Self {
        return Swift.abs(self)
    }
    
    /// YYSwift: Check if integer is positive.
    var isPositive: Bool {
        return self > 0
    }
    
    /// YYSwift: Check if integer is negative.
    var isNegative: Bool {
        return self < 0
    }
    
    #if canImport(Foundation)
    /// YYSwift: Ceil of number.
    var ceil: Self {
        return Foundation.ceil(self)
    }
    #endif
    
    #if canImport(Foundation)
    /// YYSwift: Floor of number.
    var floor: Self {
        return Foundation.floor(self)
    }
    #endif
    
    /// YYSwift: Radian value of degree input.
    var degreesToRadians: Self {
        return Self.pi * self / Self(180)
    }
    
    /// YYSwift: Degree value of radian input.
    var radiansToDegrees: Self {
        return self * Self(180) / Self.pi
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

