//
//  ArrayExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/10/30.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

// MARK: - Initializer
public extension Array {
    
    /// YYSwift: Creates and returns an array from a specified property list data.
    /// A property list data whose root object is an array.
    public init?(plistData: Data) {
        let array = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil)
        if array != nil && array is Array {
            self = array as! Array
            return
        }
        return nil
    }
}

// MARK: - Properties
public extension Array {
    
    /// YYSwift: Serialize the array to a xml property list string.
    public var plistData: Data? {
        do {
            return try PropertyListSerialization.data(fromPropertyList: self, format: .xml, options: 0)
        }
        catch {
            return nil
        }
    }
    
    /// YYSwift: Serialize the array to a xml property list string.
    public var plistString: String? {
        do {
            let xmlData = try PropertyListSerialization.data(fromPropertyList: self, format: .xml, options: 0)
            return xmlData.utf8String
        } catch {
            return nil
        }
    }
}

// MARK: - Methods
public extension Array {
    
    /// YYSwift: Pop first element.
    ///
    /// - Returns: the array without first element.
    @discardableResult
    public mutating func popFirst() -> Array.Element? {
        guard !isEmpty else {
            return nil
        }
        let object = self[safeAt: 0]
        self.remove(at: 0)
        return object
    }
    
    /// YYSwift: Element at the given index if it exists.
    ///
    ///     [1, 2, 3, 4, 5].item(at: 2) -> 3
    ///     [1.2, 2.3, 4.5, 3.4, 4.5].item(at: 3) -> 3.4
    ///     ["h", "e", "l", "l", "o"].item(at: 10) -> nil
    ///
    /// - Parameter index: index of element.
    /// - Returns: optional element (if exists).
    public func item(at index: Int) -> Element? {
        guard startIndex..<endIndex ~= index else { return nil }
        return self[index]
    }
    
    /// YYSwift: Insert an element at the beginning of array.
    ///
    ///     [2, 3, 4, 5].prepend(1) -> [1, 2, 3, 4, 5]
    ///     ["e", "l", "l", "o"].prepend("h") -> ["h", "e", "l", "l", "o"]
    ///
    /// - Parameter newElement: element to insert.
    public mutating func prepend(_ newElement: Element) {
        insert(newElement, at: 0)
    }
    
    /// YYSwift: Insert a array of elements.
    ///
    /// - Parameters:
    ///   - elements: element array.
    ///   - index: the index to insert.
    public mutating func insert(elements: [Element], at index: Int) {
        var i = index
        for item in elements {
            i += 1
            insert(item, at: i)
        }
    }
    
    /// YYSwift: Safely Swap values at index positions.
    ///
    ///     [1, 2, 3, 4, 5].safeSwap(from: 3, to: 0) -> [4, 2, 3, 1, 5]
    ///     ["h", "e", "l", "l", "o"].safeSwap(from: 1, to: 0) -> ["e", "h", "l", "l", "o"]
    ///
    /// - Parameters:
    ///   - index: index of first element.
    ///   - otherIndex: index of other element.
    public mutating func safeSwap(from index: Int, to otherIndex: Int) {
        guard index != otherIndex,
            startIndex..<endIndex ~= index,
            startIndex..<endIndex ~= otherIndex else {
                return
            }
        swapAt(index, otherIndex)
    }
    
    /// YYSwift: Get first index where condition is met.
    ///
    ///     [1, 7, 1, 2, 4, 1, 6].firstIndex { $0 % 2 == 0 } -> 3
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: first index where the specified condition evaluates to true. (optional)
    public func firstIndex(where condition: (Element) throws -> Bool) rethrows -> Int? {
        for (index, value) in lazy.enumerated() {
            if try condition(value) {
                return index
            }
        }
        return nil
    }
    
    /// YYSwift: Get last index where condition is met.
    ///
    ///     [1, 7, 1, 2, 4, 1, 8].lastIndex { $0 % 2 == 0 } -> 6
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: last index where the specified condition evaluates to true. (optional)
    public func lastIndex(where condition: (Element) throws -> Bool) rethrows -> Int? {
        for (index, value) in lazy.enumerated().reversed() {
            if try condition(value) {
                return index
            }
        }
        return nil
    }
    
    /// YYSwift: Get all indices where condition is met.
    ///
    ///     [1, 7, 1, 2, 4, 1, 8].indices(where: { $0 == 1 }) -> [0, 2, 5]
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: all indices where the specified condition evaluates to true. (optional)
    public func indices(where condition: (Element) throws -> Bool) rethrows -> [Int]? {
        var indices: [Int] = []
        for (index, value) in lazy.enumerated() {
            if try condition(value) {
                indices.append(index)
            }
        }
        return indices.isEmpty ? nil : indices
    }
    
    /// YYSwift: Check if all elements in array match a conditon.
    ///
    ///     [2, 2, 4].all(matching: {$0 % 2 == 0}) -> true
    ///     [1,2, 2, 4].all(matching: {$0 % 2 == 0}) -> false
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when all elements in the array match the specified condition.
    public func all(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try !condition($0) }
    }
    
    /// YYSwift: Get last element that satisfies a conditon.
    ///
    ///     [2, 2, 4, 7].last(where: {$0 % 2 == 0}) -> 4
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: the last element in the array matching the specified condition. (optional)
    public func last(where condition: (Element) throws -> Bool) rethrows -> Element? {
        for element in reversed() {
            if try condition(element) {
                return element
            }
        }
        return nil
    }
    
    /// YYSwift: Filter elements based on a rejection condition.
    ///
    ///     [2, 2, 4, 7].delete(where: {$0 % 2 == 0}) -> [7]
    ///
    /// - Parameter condition: to evaluate the exclusion of an element from the array.
    /// - Returns: the array with rejected values filtered from it.
    public func delete(where condition: (Element) throws -> Bool) rethrows -> [Element] {
        return try filter { return try !condition($0) }
    }
    
    /// YYSwift: Get element count based on condition.
    ///
    ///     [2, 2, 4, 7].count(where: {$0 % 2 == 0}) -> 3
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: number of times the condition evaluated to true.
    public func count(where condition: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self {
            if try condition(element) {
                count += 1
            }
        }
        return count
    }
    
    /// YYSwift: Iterate over a collection in reverse order. (right to left)
    ///
    ///     [0, 2, 4, 7].forEachReversed({ print($0)}) -> //Order of print: 7,4,2,0
    ///
    /// - Parameter body: a closure that takes an element of the array as a parameter.
    public func forEachReversed(_ execute: (Element) throws -> Void) rethrows {
        try reversed().forEach { try execute($0) }
    }
    
    /// YYSwift: Calls given closure with each element where condition is true.
    ///
    ///        [0, 2, 4, 7].forEach(where: {$0 % 2 == 0}, execute: { print($0)}) -> //print: 0, 2, 4
    ///
    /// - Parameters:
    ///   - condition: condition to evaluate each element against.
    ///   - body: a closure that takes an element of the array as a parameter.
    public func forEach(where condition: (Element) throws -> Bool, execute: (Element) throws -> Void) rethrows {
        for element in self where try condition(element) {
            try execute(element)
        }
    }
    
    /// YYSwift: Returns an array of slices of length "size" from the array.  If array can't be split evenly, the final slice will be the remaining elements.
    ///
    ///     [0, 2, 4, 7].group(by: 2) -> [[0, 2], [4, 7]]
    ///     [0, 2, 4, 7, 6].group(by: 2) -> [[0, 2], [4, 7], [6]]
    ///
    /// - Parameters:
    ///   - stepSize: The size of the slices to be returned.
    public func group(by stepSize: Int) -> [[Element]]? {
        guard stepSize > 0, !isEmpty else {
            return nil
        }
        var dealtCount = 0
        var slices: [[Element]] = []
        while dealtCount < count {
            slices.append(Array(self[Swift.max(dealtCount, startIndex)..<Swift.min(dealtCount + stepSize, endIndex)]))
            dealtCount += stepSize
        }
        return slices
    }
    
    /// YYSwift: Group the elements of the array in a dictionary.
    ///
    ///     [0, 2, 5, 4, 7].groupByKey { $0%2 ? "evens" : "odds" } -> [ "evens" : [0, 2, 4], "odds" : [5, 7] ]
    ///
    /// - Parameter getKey: Clousure to define the key for each element.
    /// - Returns: A dictionary with values grouped with keys.
    public func groupByKey<Key: Hashable>(keyForValue: (_ element: Element) throws -> Key) rethrows -> [Key: [Element]] {
        var group: [Key: [Element]] = [:]
        for value in self {
            let key = try keyForValue(value)
            group[key] = (group[key] ?? []) + [value]
        }
        return group
    }
    
    
    /// YYSwift: Shuffle array. (Using Fisher-Yates Algorithm)
    ///
    ///     [1, 2, 3, 4, 5].shuffle() // shuffles array
    ///
    public mutating func shuffle() {
        guard count > 1 else {
            return
        }
        for index in startIndex..<endIndex - 1 {
            let randomIndex = Int(arc4random_uniform(UInt32(endIndex - index))) + index
            if index != randomIndex { swapAt(index, randomIndex) }
        }
    }
    
    /// YYSwift: Shuffled version of array. (Using Fisher-Yates Algorithm)
    ///
    ///     [1, 2, 3, 4, 5].shuffled // return a shuffled version from given array e.g. [2, 4, 1, 3, 5].
    ///
    /// - Returns: the array with its elements shuffled.
    public func shuffled() -> [Element] {
        var array = self
        array.shuffle()
        return array
    }
}

public extension Array where Element: Numeric {
    
    /// YYSwift: Sum of all elements in array.
    ///
    ///     [1, 2, 3, 4, 5].sum() -> 15
    ///
    /// - Returns: sum of the array's elements.
    public func sum() -> Element {
        return reduce(0, +)
    }
}

public extension Array where Element: FloatingPoint {

    /// YYSwift: Average of all elements in array.
    ///
    ///     [1.2, 2.3, 4.5, 3.4, 4.5].average() = 3.18
    ///
    /// - Returns: average of the array's elements.
    public func average() -> Element {
        return isEmpty ? 0 : reduce(0, +) / Element(count)
    }
    
}

public extension Array where Element: Equatable {
    
    /// YYSwift: Check if array contains an array of elements.
    ///
    ///     [1, 2, 3, 4, 5].contains([1, 2]) -> true
    ///     [1.2, 2.3, 4.5, 3.4, 4.5].contains([2, 6]) -> false
    ///     ["h", "e", "l", "l", "o"].contains(["l", "o"]) -> true
    ///     [1, 2, 3, 4, 5].contains([1, 7]) -> false
    ///
    /// - Parameter elements: array of elements to check.
    /// - Returns: true if array contains all given items.
    public func contains(_ elements: [Element]) -> Bool {
        guard !elements.isEmpty else {
            return true
        }
        var found = true
        for element in elements {
            if !contains(element) {
                found = false
            }
        }
        return found
    }
    
    /// YYSwift: All indexes of specified item.
    ///
    ///     [1, 2, 2, 3, 4, 2, 5].indexes(of 2) -> [1, 2, 5]
    ///     [1.2, 2.3, 4.5, 3.4, 4.5].indexes(of 2.3) -> [1]
    ///     ["h", "e", "l", "l", "o"].indexes(of "l") -> [2, 3]
    ///
    /// - Parameter item: item to check.
    /// - Returns: an array with all indexes of the given item.
    public func indexes(of item: Element) -> [Int] {
        var indexes: [Int] = []
        for index in startIndex..<endIndex where self[index] == item {
            indexes.append(index)
        }
        return indexes
    }
    
    /// YYSwift: Remove all instances of an item from array.
    ///
    ///     [1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 3, 4, 5]
    ///     ["h", "e", "l", "l", "o"].removeAll("l") -> ["h", "e", "o"]
    ///
    /// - Parameter item: item to remove.
    public mutating func removeAll(_ item: Element) {
        self = filter { $0 != item }
    }
    
    /// YYSwift: Remove all instances contained in items parameter from array.
    ///
    ///     [1, 2, 2, 3, 4, 5].removeAll([2,5]) -> [1, 3, 4]
    ///     ["h", "e", "l", "l", "o"].removeAll(["l", "h"]) -> ["e", "o"]
    ///
    /// - Parameter items: items to remove.
    public mutating func removeAll(_ items: [Element]) {
        guard !items.isEmpty else {
            return
        }
        self = filter { !items.contains($0) }
    }
    
    /// YYSwift: Remove all duplicate elements from Array.
    ///
    ///     [1, 2, 2, 3, 4, 5].removeDuplicates() -> [1, 2, 3, 4, 5]
    ///     ["h", "e", "l", "l", "o"]. removeDuplicates() -> ["h", "e", "l", "o"]
    ///
    public mutating func removeDuplicates() {
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
    
    /// YYSwift: Return array with all duplicate elements removed.
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].duplicatesRemoved() -> [1, 2, 3, 4, 5])
    ///     ["h", "e", "l", "l", "o"].duplicatesRemoved() -> ["h", "e", "l", "o"])
    ///
    /// - Returns: an array of unique elements.
    ///
    public func duplicatesRemoved() -> [Element] {
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
    
    /// YYSwift: First index of a given item in an array.
    ///
    ///     [1, 2, 2, 3, 4, 2, 5].firstIndex(of: 2) -> 1
    ///     [1.2, 2.3, 4.5, 3.4, 4.5].firstIndex(of: 6.5) -> nil
    ///     ["h", "e", "l", "l", "o"].firstIndex(of: "l") -> 2
    ///
    /// - Parameter item: item to check.
    /// - Returns: first index of item in array (if exists).
    public func firstIndex(of item: Element) -> Int? {
        for (index, value) in lazy.enumerated() where value == item {
            return index
        }
        return nil
    }
    
    /// YYSwift: Last index of element in array.
    ///
    ///     [1, 2, 2, 3, 4, 2, 5].lastIndex(of: 2) -> 5
    ///     [1.2, 2.3, 4.5, 3.4, 4.5].lastIndex(of: 6.5) -> nil
    ///     ["h", "e", "l", "l", "o"].lastIndex(of: "l") -> 3
    ///
    /// - Parameter item: item to check.
    /// - Returns: last index of item in array (if exists).
    public func lastIndex(of item: Element) -> Int? {
        for (index, value) in lazy.enumerated().reversed() where value == item {
            return index
        }
        return nil
    }
}
