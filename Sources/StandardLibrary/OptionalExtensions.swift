//
//  OptionalExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/4.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

infix operator ??= : AssignmentPrecedence

public extension Optional {
    
    public func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
    
    public func run(_ block: (Wrapped) -> Void) {
        _ = self.map(block)
    }
    
    public static func ??= (lhs: inout Optional, rhs: Optional) {
        guard let rhs = rhs else {
            return
        }
        lhs = rhs
    }
}
