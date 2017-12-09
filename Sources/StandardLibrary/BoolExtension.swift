//
//  BoolExtension.swift
//  YYSwift
//
//  Created by Phoenix on 2017/11/16.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension Bool {
    
    public var int: Int {
        return self ? 1 : 0
    }
    
    public var string: String {
        return description
    }
    
    public var toggled: Bool {
        return !self
    }
    
    public static var random: Bool {
        return arc4random_uniform(2) == 1
    }
}

public extension Bool {
    
    @discardableResult
    public mutating func toggle() -> Bool {
        self = !self
        return self
    }
}
