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

public extension CGFloat {
    
    public var abs: CGFloat {
        return Swift.abs(self)
    }

    public var ceil: CGFloat {
        return Foundation.ceil(self)
    }
    
    public var degreesToRadians: CGFloat {
        return CGFloat.pi * self / 180.0
    }
    
    public var floor: CGFloat {
        return Foundation.floor(self)
    }
    
    public var isPositive: Bool {
        return self > 0
    }
    
    public var isNegative: Bool {
        return self < 0
    }
    
    public var int: Int {
        return Int(self)
    }
    
    public var float: Float {
        return Float(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }
    
}

public extension CGFloat {
    
    public static func randomBetween(min: CGFloat, max: CGFloat) -> CGFloat {
        let delta = max - min
        return min + CGFloat(arc4random_uniform(UInt32(delta)))
    }
    
}
