//
//  FloatExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/11/28.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation
import CoreGraphics

public extension Float {
    
    public var int: Int {
        return Int(self)
    }
    
    public var double: Float {
        return Float(self)
    }
    
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
}

prefix operator √
public prefix func √ (double: Float) -> Float {
    return sqrt(double)
}

precedencegroup PowerPrecedence {
    higherThan: MultiplicationPrecedence
}
infix operator ^ : PowerPrecedence
public func ^ (lhs: Float, rhs: Float) -> Float {
    return pow(lhs, rhs)
}
