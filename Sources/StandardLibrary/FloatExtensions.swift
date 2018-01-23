//
//  FloatExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/11/28.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation
import CoreGraphics

// MARK: - Properties
public extension Float {
    
    /// YYSwift: Int.
    public var int: Int {
        return Int(self)
    }
    
    /// YYSwift: Double.
    public var double: Float {
        return Float(self)
    }
    
    /// YYSwift: CGFloat.
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
}

prefix operator √
/// YYSwift: Square root of float.
///
/// - Parameter float: float value to find square root for
/// - Returns: square root of given float.
public prefix func √ (double: Float) -> Float {
    return sqrt(double)
}

precedencegroup PowerPrecedence {
    higherThan: MultiplicationPrecedence
}
infix operator ^ : PowerPrecedence
/// YYSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base float.
///   - rhs: exponent float.
/// - Returns: exponentiation result (4.4 ^ 0.5 = 2.0976176963).
public func ^ (lhs: Float, rhs: Float) -> Float {
    return pow(lhs, rhs)
}
