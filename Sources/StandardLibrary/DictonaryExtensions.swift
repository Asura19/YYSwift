//
//  DictonaryExtensions.swift
//  YYKitBase
//
//  Created by Phoenix on 2017/11/27.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension Dictionary where Key: Comparable {
    
    public func allKeySorted() -> Array<Key> {
        return keys.sorted()
    }
    
    public func allValuesSortedByKeys() -> Array<Value> {
        let sortedKeys = allKeySorted()
        var array = [Value]()
        for key in sortedKeys {
            array.append(self[key]!)
        }
        return array
    }
}

public extension Dictionary {
    
    public func containsValue(forKey key: Key) -> Bool {
        return self[key] != nil
    }
    
    public func entriesFor(keys: [Key]) -> [Key: Value] {
        var dic = [Key: Value]()
        for key in keys {
            if let value = self[key] {
                dic[key] = value
            }
        }
        return dic
    }
    
    public func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    public mutating func removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0) })
    }
    
    public func jsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = prettify ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
    
    public func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = prettify ? JSONSerialization.WritingOptions.prettyPrinted :
        JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
    
    public func count(where condition: @escaping ((key: Key, value: Value)) throws -> Bool) rethrows -> Int {
        var count: Int = 0
        try self.forEach {
            if try condition($0) {
                count += 1
            }
        }
        return count
    }
}

public extension Dictionary {
    
    public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }
    
    public static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0] = $1}
    }
}

public extension Dictionary where Key: ExpressibleByStringLiteral {
    
    public mutating func lowercaseAllKeys() {
        for key in keys {
            if let lowercaseKey = String(describing: key).lowercased() as? Key {
                self[lowercaseKey] = removeValue(forKey: key)
            }
        }
    }
}



