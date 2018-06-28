//
//  IntExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/11/28.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation
import CoreGraphics

// MARK: - Properties
public extension Int {
    
    /// YYSwift: Bool
    public var bool: Bool {
        return self != 0
    }
    
    /// YYSwift: CountableRange 0..<Int.
    public var countableRange: CountableRange<Int> {
        return 0..<self
    }
    
    /// YYSwift: Radian value of degree input.
    public var degreesToRadians: Double {
        return Double.pi * Double(self) / 180.0
    }
    
    /// YYSwift: Degree value of radian input
    public var radiansToDegrees: Double {
        return Double(self) * 180 / Double.pi
    }
    
    /// YYSwift: UInt.
    public var uInt: UInt {
        return UInt(self)
    }
    
    /// YYSwift: Double.
    public var double: Double {
        return Double(self)
    }
    
    /// YYSwift: Float.
    public var float: Float {
        return Float(self)
    }
    
    /// YYSwift: CGFloat.
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    /// YYSwift: String formatted for values over ±1000 (example: 1k, -2k, 100k, 1kk, -5kk..)
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
    
    /// YYSwift: Array of digits of integer value.
    public var digits: [Int] {
        guard self != 0 else { return [0] }
        var digits = [Int]()
        var number = self.abs
        
        while number != 0 {
            let x = number % 10
            digits.append(x)
            number = number / 10
        }
        
        digits.reverse()
        return digits
    }
    
    /// YYSwift: Number of digits of integer value.
    public var digitsCount: Int {
        guard self != 0 else { return 1 }
        let number = Double(self.abs)
        return Int(log10(number) + 1)
    }
}

public extension Int {
    
    /// YYSwift: check if given integer prime or not.
    /// Warning: Using big numbers can be computationally expensive!
    /// - Returns: true or false depending on prime-ness
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
    
    /// YYSwift: Roman numeral string from integer (if applicable).
    ///
    ///     10.romanNumeral() -> "X"
    ///
    /// - Returns: The roman numeral string.
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


precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^ : PowerPrecedence
/// YYSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base integer.
///   - rhs: exponent integer.
/// - Returns: exponentiation result (example: 2 ^ 3 = 8).
public func ^ (lhs: Int, rhs: Int) -> Double {
    return pow(Double(lhs), Double(rhs))
}

prefix operator √
/// YYSwift: Square root of integer.
///
/// - Parameter int: integer value to find square root for
/// - Returns: square root of given integer.
public prefix func √ (int: Int) -> Double {
    return sqrt(Double(int))
}

infix operator ±
/// YYSwift: Return a closed range with ±
///
///     2 ± 3 -> -1...5
/// - Parameters:
///   - lhs: integer number.
///   - rhs: integer number.
/// - Returns: a closed range
public func ± (lhs: Int, rhs: Int) -> ClosedRange<Int> {
    return (lhs - rhs)...(lhs + rhs)
}

prefix operator ±
/// YYSwift: Tuple of plus-minus operation.
///
/// - Parameter int: integer number
/// - Returns: tuple of plus-minus operation (example: ± 2 -> (2, -2)).
public prefix func ± (int: Int) -> (Int, Int) {
    return (0 + int, 0 - int)
}



