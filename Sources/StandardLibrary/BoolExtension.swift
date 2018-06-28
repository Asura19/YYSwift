//
//  BoolExtension.swift
//  YYSwift
//
//  Created by Phoenix on 2017/11/16.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

// MARK: - Properties
public extension Bool {
    
    /// YYSwift: Return 1 if true, or 0 if false.
    ///
    ///     false.int -> 0
    ///     true.int -> 1
    ///
    public var int: Int {
        return self ? 1 : 0
    }
    
    /// YYSwift: Return "true" if true, or "false" if false.
    ///
    ///     false.string -> "false"
    ///     true.string -> "true"
    ///
    public var string: String {
        return description
    }
    
    /// YYSwift: Return inversed value of bool.
    ///
    ///     false.toggled -> true
    ///     true.toggled -> false
    ///
    public var toggled: Bool {
        return !self
    }
    
}

