//
//  ArrayExtensions.swift
//  YYKitBase
//
//  Created by Phoenix on 2017/10/30.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension Array {
    
    public init?(plistData: Data) {
        let array = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil)
        if array != nil && array is Array {
            self = array as! Array
            return
        }
        return nil
    }
    
    // 有些问题
    //    init?(plistString: String) {
    //        let data = plistString.data(using: .utf8)
    //        print(data!.description)
    //        if data != nil {
    //            if let array = Array(plistData: data!) {
    //                self = array
    //            }
    //            return nil
    //        }
    //        return nil
    //    }
    
    public var plistData: Data? {
        do {
            return try PropertyListSerialization.data(fromPropertyList: self, format: .xml, options: 0)
        }
        catch {
            return nil
        }
    }
    
    public var plistString: String? {
        do {
            let xmlData = try PropertyListSerialization.data(fromPropertyList: self, format: .xml, options: 0)
            return xmlData.utf8String
        } catch {
            return nil
        }
    }

}

public extension Array {
    
    @discardableResult
    public mutating func popFirst() -> Array.Element? {
        guard !isEmpty else {
            return nil
        }
        let object = self[safeAt: 0]
        self.remove(at: 0)
        return object
    }
    
    public mutating func prepend(_ newElement: Element) {
        insert(newElement, at: 0)
    }
    
    public mutating func insert(elements: [Element], at index: Int) {
        var i = index
        for item in elements {
            i += 1
            insert(item, at: i)
        }
    }
    
    public mutating func safeSwap(from index: Int, to otherIndex: Int) {
        guard index != otherIndex,
            startIndex..<endIndex ~= index,
            startIndex..<endIndex ~= otherIndex else { return }
        swapAt(index, otherIndex)
    }
    
    public func firstIndex(where condition: (Element) throws -> Bool) rethrows -> Int? {
        for (index, value) in lazy.enumerated() {
            if try condition(value) {
                return index
            }
        }
        return nil
    }
    
    public func lastIndex(where condition: (Element) throws -> Bool) rethrows -> Int? {
        for (index, value) in lazy.enumerated().reversed() {
            if try condition(value) {
                return index
            }
        }
        return nil
    }
    
    public func indices(where condition: (Element) throws -> Bool) rethrows -> [Int]? {
        var indices: [Int] = []
        for (index, value) in lazy.enumerated() {
            if try condition(value) {
                indices.append(index)
            }
        }
        return indices.isEmpty ? nil : indices
    }
    
    public func all(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try !condition($0) }
    }
    
    public func last(where condition: (Element) throws -> Bool) rethrows -> Element? {
        for element in reversed() {
            if try condition(element) {
                return element
            }
        }
        return nil
    }
    
    public func delete(where condition: (Element) throws -> Bool) rethrows -> [Element] {
        return try filter { return try !condition($0) }
    }
    
    public func count(where condition: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self {
            if try condition(element) {
                count += 1
            }
        }
        return count
    }
    
    public func forEachReversed(_ execute: (Element) throws -> Void) rethrows {
        try reversed().forEach { try execute($0) }
    }
    
    public func forEach(where condition: (Element) throws -> Bool, execute: (Element) throws -> Void) rethrows {
        for element in self where try condition(element) {
            try execute(element)
        }
    }
    
    public func group(by stepSize: Int) -> [[Element]]? {
        guard stepSize > 0, !isEmpty else { return nil }
        var dealtCount = 0
        var slices: [[Element]] = []
        while dealtCount < count {
            slices.append(Array(self[Swift.max(dealtCount, startIndex)..<Swift.min(dealtCount + stepSize, endIndex)]))
            dealtCount += stepSize
        }
        return slices
    }
    
    public func groupByKey<Key: Hashable>(keyForValue: (_ element: Element) throws -> Key) rethrows -> [Key: [Element]] {
        var group = [Key: [Element]]()
        for value in self {
            let key = try keyForValue(value)
            group[key] = (group[key] ?? []) + [value]
        }
        return group
    }
}

public extension Array where Element: Numeric {
    
    public func sum() -> Element {
        return reduce(0, +)
    }
}

public extension Array where Element: FloatingPoint {

    public func average() -> Element {
        return isEmpty ? 0 : reduce(0, +) / Element(count)
    }
    
}

public extension Array where Element: Equatable {
    
    public mutating func shuffle() {
        guard count > 1 else { return }
        for index in startIndex..<endIndex - 1 {
            let randomIndex = Int(arc4random_uniform(UInt32(endIndex - index))) + index
            if index != randomIndex { swapAt(index, randomIndex) }
        }
    }
    
    public func shuffled() -> [Element] {
        var array = self
        array.shuffle()
        return array
    }
    
    public func contains(_ elements: [Element]) -> Bool {
        guard !elements.isEmpty else { return true }
        var found = true
        for element in elements {
            if !contains(element) {
                found = false
            }
        }
        return found
    }
    
    public func indexes(of item: Element) -> [Int] {
        var indexes: [Int] = []
        for index in startIndex..<endIndex where self[index] == item {
            indexes.append(index)
        }
        return indexes
    }
    
    public mutating func removeAll(_ item: Element) {
        self = filter { $0 != item }
    }
    
    public mutating func removeAll(_ items: [Element]) {
        guard !items.isEmpty else { return }
        self = filter { !items.contains($0) }
    }
    
    public mutating func removeDuplicates() {
//        self = reduce(into: [Element]()) { result, item in
//            if !result.contains(item) {
//                result.append(item)
//            }
//        }
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
    
    public func duplicatesRemoved() -> [Element] {
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
    
    public func firstIndex(of item: Element) -> Int? {
        for (index, value) in lazy.enumerated() where value == item {
            return index
        }
        return nil
    }
    
    public func lastIndex(of item: Element) -> Int? {
        for (index, value) in lazy.enumerated().reversed() where value == item {
            return index
        }
        return nil
    }
}
