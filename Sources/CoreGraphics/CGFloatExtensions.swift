//
//  CGFloatExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/13.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

// MARK: - Properties
public extension CGFloat {
    
    /// YYSwift: Absolute of CGFloat value.
    var abs: CGFloat {
        return Swift.abs(self)
    }

    /// YYSwift: Ceil of CGFloat value.
    var ceil: CGFloat {
        return Foundation.ceil(self)
    }
    
    /// YYSwift: Radian value of degree input.
    var degreesToRadians: CGFloat {
        return .pi * self / 180.0
    }
    
    /// YYSwift: Floor of CGFloat value.
    var floor: CGFloat {
        return Foundation.floor(self)
    }
    
    /// YYSwift: Check if CGFloat is positive.
    var isPositive: Bool {
        return self > 0
    }
    
    /// YYSwift: Check if CGFloat is negative.
    var isNegative: Bool {
        return self < 0
    }
    
    /// YYSwift: Int.
    var int: Int {
        return Int(self)
    }
    
    /// YYSwift: Float.
    var float: Float {
        return Float(self)
    }
    
    /// YYSwift: Double.
    var double: Double {
        return Double(self)
    }
    
    /// YYSwift: Degree value of radian input.
    var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }
    
}

#endif
