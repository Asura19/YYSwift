//
//  DoubleExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/11/27.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation
import CoreGraphics

// MARK: - Properties
public extension Double {
    
    /// YYSwift: Int.
    public var int: Int {
        return Int(self)
    }
    
    /// YYSwift: Float.
    public var float: Float {
        return Float(self)
    }
    
    /// YYSwift: CGFloat.
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
}

// MARK: - Operators

prefix operator √
/// YYSwift: Square root of double.
///
/// - Parameter double: double value to find square root for.
/// - Returns: square root of given double.
public prefix func √ (double: Double) -> Double {
    return sqrt(double)
}

precedencegroup PowerPrecedence {
    higherThan: MultiplicationPrecedence
}
infix operator ^ : PowerPrecedence
/// YYSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base double.
///   - rhs: exponent double.
/// - Returns: exponentiation result (example: 4.4 ^ 0.5 = 2.0976176963).
public func ^ (lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}
