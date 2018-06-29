//
//  ArrayExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/10/30.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(Foundation)
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
    public mutating func safeSwap(from index: Index, to otherIndex: Index) {
        guard index != otherIndex,
            startIndex..<endIndex ~= index,
            startIndex..<endIndex ~= otherIndex else {
                return
            }
        swapAt(index, otherIndex)
    }
    
    /// YYSwift: Keep elements of Array while condition is true.
    ///
    ///        [0, 2, 4, 7].keep( where: {$0 % 2 == 0}) -> [0, 2, 4]
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: self after applying provided condition.
    /// - Throws: provided condition exception.
    @discardableResult
    public mutating func keep(while condition: (Element) throws -> Bool) rethrows -> [Element] {
        for (index, element) in lazy.enumerated() where try !condition(element) {
            self = Array(self[startIndex..<index])
            break
        }
        return self
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
    
    /// YYSwift: Separates an array into 2 arrays based on a predicate.
    ///
    ///     [0, 1, 2, 3, 4, 5].divided { $0 % 2 == 0 } -> ( [0, 2, 4], [1, 3, 5] )
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: Two arrays, the first containing the elements for which the specified condition evaluates to true, the second containing the rest.
    public func divided(by condition: (Element) throws -> Bool) rethrows -> (matching: [Element], nonMatching: [Element]) {
        var matching = [Element]()
        var nonMatching = [Element]()
        for element in self {
            if try condition(element) {
                matching.append(element)
            } else {
                nonMatching.append(element)
            }
        }
        return (matching, nonMatching)
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
    
    /// YYSwift: Returns a sorted array based on an optional keypath.
    ///
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Parameter ascending: If order must be ascending.
    /// - Returns: Sorted array based on keyPath.
    public func sorted<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool = true) -> [Element] {
        return sorted(by: { (lhs, rhs) -> Bool in
            guard let lhsValue = lhs[keyPath: path], let rhsValue = rhs[keyPath: path] else { return false }
            if ascending {
                return lhsValue < rhsValue
            }
            return lhsValue > rhsValue
        })
    }
    
    /// YYSwift: Returns a sorted array based on a keypath.
    ///
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Parameter ascending: If order must be ascending.
    /// - Returns: Sorted array based on keyPath.
    public func sorted<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        return sorted(by: { (lhs, rhs) -> Bool in
            if ascending {
                return lhs[keyPath: path] < rhs[keyPath: path]
            }
            return lhs[keyPath: path] > rhs[keyPath: path]
        })
    }
    
    /// YYSwift: Sort the array based on an optional keypath.
    ///
    /// - Parameters:
    ///   - path: Key path to sort, must be Comparable.
    ///   - ascending: whether order is ascending or not.
    /// - Returns: self after sorting.
    @discardableResult
    public mutating func sort<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool = true) -> [Element] {
        self = sorted(by: path, ascending: ascending)
        return self
    }
    
    /// YYSwift: Sort the array based on a keypath.
    ///
    /// - Parameters:
    ///   - path: Key path to sort, must be Comparable.
    ///   - ascending: whether order is ascending or not.
    /// - Returns: self after sorting.
    @discardableResult
    public mutating func sort<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        self = sorted(by: path, ascending: ascending)
        return self
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
    
    /// YYSwift: Removes the first element of the collection which satisfies the given predicate.
    ///
    ///        [1, 2, 2, 3, 4, 2, 5].removeFirst { $0 % 2 == 0 } -> [1, 2, 3, 4, 2, 5]
    ///        ["h", "e", "l", "l", "o"].removeFirst { $0 == "e" } -> ["h", "l", "l", "o"]
    ///
    /// - Parameter predicate: A closure that takes an element as its argument and returns a Boolean value that indicates whether the passed element represents a match.
    /// - Returns: The first element for which predicate returns true, after removing it. If no elements in the collection satisfy the given predicate, returns `nil`.
    @discardableResult
    public mutating func removeFirst(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        guard let index = try index(where: predicate) else { return nil }
        return remove(at: index)
    }
    
}
#endif
