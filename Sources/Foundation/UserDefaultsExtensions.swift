//
//  UserDefaultsExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/9.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    public subscript(_ key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    public func float(forKey key: String) -> Float? {
        return object(forKey: key) as? Float
    }
    
    public func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }
}
