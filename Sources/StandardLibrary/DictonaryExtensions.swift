//
//  DictonaryExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/11/27.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension Dictionary where Key: Comparable {
    
    public func allKeySorted() -> [Key] {
        return keys.sorted()
    }
    
    /// YYSwift: Returns a new array containing the dictionary's values sorted by keys.
    ///
    /// - Returns: A new array containing the dictionary's values sorted by keys,
    ///            or an empty array if the dictionary has no entries.
    public func allValuesSortedByKeys() -> [Value] {
        let sortedKeys = allKeySorted()
        var array: [Value] = []
        for key in sortedKeys {
            array.append(self[key]!)
        }
        return array
    }
}

public extension Dictionary {
    
    /// YYSwift: Returns a Bool value tells if the dictionary has an object for key.
    public func containsValue(forKey key: Key) -> Bool {
        return self[key] != nil
    }
    
    /// YYSwift: Returns a new dictionary containing the entries for keys.
    /// If the keys is empty or nil, it just returns an empty dictionary.
    ///
    /// - Parameter keys: The keys.
    /// - Returns: The entries for the keys.
    public func entriesFor(keys: [Key]) -> [Key: Value] {
        var dic: [Key: Value] = [:]
        for key in keys {
            if let value = self[key] {
                dic[key] = value
            }
        }
        return dic
    }
    
    /// YYSwift: Check if key exists in dictionary.
    ///
    ///     let dict: [String : Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
    ///     dict.has(key: "testKey") -> true
    ///     dict.has(key: "anotherKey") -> false
    ///
    /// - Parameter key: key to search for
    /// - Returns: true if key exists in dictionary.
    public func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    /// YYSwift: Remove all keys of the dictionary.
    ///
    ///     var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///     dict.removeAll(keys: ["key1", "key2"])
    ///     dict.keys.contains("key3") -> true
    ///     dict.keys.contains("key1") -> false
    ///     dict.keys.contains("key2") -> false
    ///
    /// - Parameter keys: keys to be removed
    public mutating func removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0) })
    }
    
    /// YYSwift: JSON Data from dictionary.
    ///
    /// - Parameter prettify: set true to prettify data (default is false).
    /// - Returns: optional JSON Data (if applicable).
    public func jsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = prettify ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
    
    /// YYSwift: JSON String from dictionary.
    ///
    ///     dict.jsonString() -> "{"testKey":"testValue","testArrayKey":[1,2,3,4,5]}"
    ///
    ///     dict.jsonString(prettify: true)
    ///     /*
    ///     returns the following string:
    ///
    ///     "{
    ///     "testKey" : "testValue",
    ///     "testArrayKey" : [
    ///         1,
    ///         2,
    ///         3,
    ///         4,
    ///         5
    ///     ]
    ///     }"
    ///
    ///     */
    ///
    /// - Parameter prettify: set true to prettify string (default is false).
    /// - Returns: optional JSON String (if applicable).
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
    
    /// YYSwift: Count dictionary entries that where function returns true.
    ///
    /// - Parameter where: condition to evaluate each tuple entry against.
    /// - Returns: Count of entries that matches the where clousure.
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
    
    /// YYSwift: Merge the keys/values of two dictionaries.
    ///
    ///     let dict : [String : String] = ["key1" : "value1"]
    ///     let dict2 : [String : String] = ["key2" : "value2"]
    ///     let result = dict + dict2
    ///     result["key1"] -> "value1"
    ///     result["key2"] -> "value2"
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    /// - Returns: An dictionary with keys and values from both.
    public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }
    
    
    /// YYSwift: Append the keys and values from the second dictionary into the first one.
    ///
    ///     var dict : [String : String] = ["key1" : "value1"]
    ///     let dict2 : [String : String] = ["key2" : "value2"]
    ///     dict += dict2
    ///     dict["key1"] -> "value1"
    ///     dict["key2"] -> "value2"
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    public static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0] = $1}
    }
}

public extension Dictionary where Key: ExpressibleByStringLiteral {
    
    /// YYSwift: Lowercase all keys in dictionary.
    ///
    ///     var dict = ["tEstKeY": "value"]
    ///     dict.lowercaseAllKeys()
    ///     print(dict) // prints "["testkey": "value"]"
    ///
    public mutating func lowercaseAllKeys() {
        for key in keys {
            if let lowercaseKey = String(describing: key).lowercased() as? Key {
                self[lowercaseKey] = removeValue(forKey: key)
            }
        }
    }
    
}



