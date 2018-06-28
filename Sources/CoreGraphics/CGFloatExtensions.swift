//
//  CGFloatExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/13.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif

// MARK: - Properties
public extension CGFloat {
    
    /// YYSwift: Absolute of CGFloat value.
    public var abs: CGFloat {
        return Swift.abs(self)
    }

    /// YYSwift: Ceil of CGFloat value.
    public var ceil: CGFloat {
        return Foundation.ceil(self)
    }
    
    /// YYSwift: Radian value of degree input.
    public var degreesToRadians: CGFloat {
        return CGFloat.pi * self / 180.0
    }
    
    /// YYSwift: Floor of CGFloat value.
    public var floor: CGFloat {
        return Foundation.floor(self)
    }
    
    /// YYSwift: Check if CGFloat is positive.
    public var isPositive: Bool {
        return self > 0
    }
    
    /// YYSwift: Check if CGFloat is negative.
    public var isNegative: Bool {
        return self < 0
    }
    
    /// YYSwift: Int.
    public var int: Int {
        return Int(self)
    }
    
    /// YYSwift: Float.
    public var float: Float {
        return Float(self)
    }
    
    /// YYSwift: Double.
    public var double: Double {
        return Double(self)
    }
    
    /// YYSwift: Degree value of radian input.
    public var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }
    
}

