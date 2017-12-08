//
//  IntExtensions.swift
//  YYKitBase
//
//  Created by Phoenix on 2017/11/28.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation
import CoreGraphics

public extension Int {
    
    public var countableRange: CountableRange<Int> {
        return 0..<self
    }
    
    public var degreesToRadians: Double {
        return Double.pi * Double(self) / 180.0
    }
    
    public var radiansToDegrees: Double {
        return Double(self) * 180 / Double.pi
    }
    
    public var uInt: UInt {
        return UInt(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var float: Float {
        return Float(self)
    }
    
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    /// String formatted for values over ±1000 (example: 1k, -2k, 100k, 1kk, -5kk..)
    public var kFormatted: String {
        let sign: String = (self >= 0) ? "" : "-"
        let abs = Swift.abs(self)
        if abs >= 0 && abs < 1000 {
            return "0k"
        }
        else if abs >= 1000 && abs < 1000000 {
            return "\(sign)\(abs / 1000)k"
        }
        return "\(sign)\(abs / 100000)kk"
    }
}

public extension Int {
    
    public static func random() -> Int {
        return random(inRange: (-Int(UInt32.max / 2))...Int(UInt32.max) / 2)
    }
    
    public static func random(between min: Int, and max: Int) -> Int {
        return random(inRange: min...max)
    }
    
    public static func random(inRange range: ClosedRange<Int>) -> Int {
        let delta = UInt32(range.upperBound - range.lowerBound + 1)
        return range.lowerBound + Int(arc4random_uniform(delta))
    }
    
    public func isPrime() -> Bool {
        if self == 2 {
            return true
        }
        guard self > 1 && self % 2 != 0 else {
            return false
        }
        
        let base = Int(sqrt(Double(self)))
        for i in Swift.stride(from: 3, through: base, by: 2) where self % i == 0 {
            return false
        }
        return true
    }
    
    public func romanNumeral() -> String? {
        
        guard self > 0 else { // there is no roman numerals for 0 or negative numbers
            return nil
        }
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        
        var romanValue = ""
        var startingValue = self
        
        for (index, romanChar) in romanValues.enumerated() {
            let arabicValue = arabicValues[index]
            let div = startingValue / arabicValue
            if div > 0 {
                for _ in 0..<div {
                    romanValue += romanChar
                }
                startingValue -= arabicValue * div
            }
        }
        return romanValue
    }

}

public extension Int {
    
    public init(randomBetween min: Int, and max: Int) {
        self = Int.random(between: min, and: max)
    }
    
    public init(randomInRange range: ClosedRange<Int>) {
        self = Int.random(inRange: range)
    }
    
}

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^ : PowerPrecedence

public func ^ (lhs: Int, rhs: Int) -> Double {
    return pow(Double(lhs), Double(rhs))
}

prefix operator √
public prefix func √ (int: Int) -> Double {
    return sqrt(Double(int))
}

infix operator ±
public func ± (lhs: Int, rhs: Int) -> ClosedRange<Int> {
    return (lhs - rhs)...(lhs + rhs)
}

prefix operator ±
public prefix func ± (int: Int) -> (Int, Int) {
    return (0 + int, 0 - int)
}



