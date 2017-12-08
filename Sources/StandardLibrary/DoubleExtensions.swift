//
//  DoubleExtensions.swift
//  YYKitBase
//
//  Created by Phoenix on 2017/11/27.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation
import CoreGraphics

public extension Double {
    
    public var int: Int {
        return Int(self)
    }
    
    public var float: Float {
        return Float(self)
    }
    
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
}


prefix operator √
public prefix func √ (double: Double) -> Double {
    return sqrt(double)
}

precedencegroup PowerPrecedence {
    higherThan: MultiplicationPrecedence
}
infix operator ^ : PowerPrecedence
public func ^ (lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}
