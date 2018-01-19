//
//  UserDefaultsExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/9.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

// MARK: - Methods
public extension UserDefaults {
    
    /// YYSwift: get object from UserDefaults by using subscript
    ///
    /// - Parameter key: key in the current user's defaults database.
    public subscript(_ key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    /// YYSwift: Float from UserDefaults.
    ///
    /// - Parameter forKey: key to find float for.
    /// - Returns: Float object for key (if exists).
    public func float(forKey key: String) -> Float? {
        return object(forKey: key) as? Float
    }
    
    /// YYSwift: Date from UserDefaults.
    ///
    /// - Parameter forKey: key to find date for.
    /// - Returns: Date object for key (if exists).
    public func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }
}
