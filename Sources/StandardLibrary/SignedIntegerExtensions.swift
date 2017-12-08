//
//  SignedIntegerExtensions.swift
//  YYKitBase
//
//  Created by Phoenix on 2017/12/4.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension SignedInteger {
    
    public var abs: Self {
        return Swift.abs(self)
    }
    
    public var isPositive: Bool {
        return self > 0
    }
    
    public var isNegative: Bool {
        return self < 0
    }
    
    public var isEven: Bool {
        return (self % 2) == 0
    }
    
    public var isOdd: Bool {
        return (self % 2) != 0
    }
    
    public var digits: [Self] {
        let intsArray = description.flatMap({Int(String($0))})
        return intsArray.map({Self($0)})
    }
    
    public var digitsCount: Int {
        return description.flatMap({Int(String($0))}).count
    }
    
    public var timeString: String {
        guard self > 0 else {
            return "0 sec"
        }
        if self < 60 {
            return "\(self) sec"
        }
        if self < 3600 {
            return "\(self / 60) min"
        }
        let hours = self / 3600
        let mins = (self % 3600) / 60
        
        if hours != 0 && mins == 0 {
            return "\(hours)h"
        }
        return "\(hours)h \(mins)m"
    }
}

public extension SignedInteger {
    
    /// Greatest common divisor of integer value and n.
    ///
    /// - Parameter n: integer value to find gcd with.
    /// - Returns: greatest common divisor of self and n.
    public func gcd(with n: Self) -> Self {
        return n == 0 ? self : n.gcd(with: self % n)
    }
    
    /// Least common multiple of integer and n.
    ///
    /// - Parameter n: integer value to find lcm with.
    /// - Returns: least common multiple of self and n.
    public func lcm(with n: Self) -> Self {
        return (self * n).abs / gcd(with: n)
    }
    
}
