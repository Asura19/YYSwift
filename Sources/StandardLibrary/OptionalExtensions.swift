//
//  OptionalExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/4.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

// MARK: - Operators
infix operator ??= : AssignmentPrecedence

public extension Optional {
    
    /// YYSwift: Get self of default value (if self is nil).
    ///
    ///     let foo: String? = nil
    ///     print(foo.unwrapped(or: "bar")) -> "bar"
    ///
    ///     let bar: String? = "bar"
    ///     print(bar.unwrapped(or: "foo")) -> "bar"
    ///
    /// - Parameter defaultValue: default value to return if self is nil.
    /// - Returns: self if not nil or default value if nil.
    public func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
    
    /// YYSwift: Runs a block to Wrapped if not nil
    ///
    ///     let foo: String? = nil
    ///     foo.run { unwrappedFoo in
    ///         // block will never run sice foo is nill
    ///         print(unwrappedFoo)
    ///     }
    ///
    ///     let bar: String? = "bar"
    ///     bar.run { unwrappedBar in
    ///         // block will run sice bar is not nill
    ///         print(unwrappedBar) -> "bar"
    ///     }
    ///
    /// - Parameter block: a block to run if self is not nil.
    public func run(_ block: (Wrapped) -> Void) {
        _ = self.map(block)
    }
    
    /// YYSwift: Assign an optional value to a variable only if the value is not nil.
    ///
    ///     let someParameter: String? = nil
    ///     let parameters = [String:Any]() //Some parameters to be attached to a GET request
    ///     parameters[someKey] ??= someParameter //It won't be added to the parameters dict
    ///
    /// - Parameters:
    ///   - lhs: Any?
    ///   - rhs: Any?
    public static func ??= (lhs: inout Optional, rhs: Optional) {
        guard let rhs = rhs else {
            return
        }
        lhs = rhs
    }
}
