//
//  CollectionExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/10/30.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Methods
public extension Collection {
    
    #if canImport(Foundation)
    /// YYSwift: Performs `each` closure for each element of collection in parallel.
    ///
    ///        array.forEachInParallel { item in
    ///            print(item)
    ///        }
    ///
    /// - Parameter each: closure to run for each element.
    func forEachInParallel(_ each: (Self.Element) -> Void) {
        let indicesArray = Array(indices)
        
        DispatchQueue.concurrentPerform(iterations: indicesArray.count) { (index) in
            let elementIndex = indicesArray[index]
            each(self[elementIndex])
        }
    }
    #endif
    
    /// YYSwift: Safe protects the array from out of bounds by use of optional.
    ///
    ///        let arr = [1, 2, 3, 4, 5]
    ///        arr[safe: 1] -> 2
    ///        arr[safe: 10] -> nil
    ///
    /// - Parameter index: index of element to access element.
    subscript(safeAt index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}

// MARK: - Methods (Int)
public extension Collection where Index == Int {
    
    #if canImport(Foundation)
    /// YYSwift: Random item from array.
    var randomItem: Element? {
        guard !isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    #endif
    
    /// YYSwift: Get the first index where condition is met.
    ///
    ///        [1, 7, 1, 2, 4, 1, 6].firstIndex { $0 % 2 == 0 } -> 3
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: first index where the specified condition evaluates to true. (optional)
    func firstIndex(where condition: (Element) throws -> Bool) rethrows -> Index? {
        for (index, value) in lazy.enumerated() where try condition(value) {
            return index
        }
        return nil
    }
    
    /// YYSwift: Get the last index where condition is met.
    ///
    ///     [1, 7, 1, 2, 4, 1, 8].lastIndex { $0 % 2 == 0 } -> 6
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: last index where the specified condition evaluates to true. (optional)
    func lastIndex(where condition: (Element) throws -> Bool) rethrows -> Index? {
        for (index, value) in lazy.enumerated().reversed() where try condition(value) {
            return index
        }
        return nil
    }
    
    /// YYSwift: Get all indices where condition is met.
    ///
    ///     [1, 7, 1, 2, 4, 1, 8].indices(where: { $0 == 1 }) -> [0, 2, 5]
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: all indices where the specified condition evaluates to true. (optional)
    func indices(where condition: (Element) throws -> Bool) rethrows -> [Index]? {
        var indicies: [Index] = []
        for (index, value) in lazy.enumerated() where try condition(value) {
            indicies.append(index)
        }
        return indicies.isEmpty ? nil : indicies
    }
    
    /// YYSwift: Calls the given closure with an array of size of the parameter slice.
    ///
    ///     [0, 2, 4, 7].forEach(slice: 2) { print($0) } -> //print: [0, 2], [4, 7]
    ///     [0, 2, 4, 7, 6].forEach(slice: 2) { print($0) } -> //print: [0, 2], [4, 7], [6]
    ///
    /// - Parameters:
    ///   - slice: size of array in each interation.
    ///   - body: a closure that takes an array of slice size as a parameter.
    func forEach(slice: Int, body: ([Element]) throws -> Void) rethrows {
        guard slice > 0, !isEmpty else { return }
        
        var value: Int = 0
        while value < count {
            try body(Array(self[Swift.max(value, startIndex)..<Swift.min(value + slice, endIndex)]))
            value += slice
        }
    }
    
    /// YYSwift: Returns an array of slices of length "size" from the array. If array can't be split evenly, the final slice will be the remaining elements.
    ///
    ///     [0, 2, 4, 7].group(by: 2) -> [[0, 2], [4, 7]]
    ///     [0, 2, 4, 7, 6].group(by: 2) -> [[0, 2], [4, 7], [6]]
    ///
    /// - Parameter size: The size of the slices to be returned.
    /// - Returns: grouped self.
    func group(by size: Int) -> [[Element]]? {
        //Inspired by: https://lodash.com/docs/4.17.4#chunk
        guard size > 0, !isEmpty else { return nil }
        var value: Int = 0
        var slices: [[Element]] = []
        while value < count {
            slices.append(Array(self[Swift.max(value, startIndex)..<Swift.min(value + size, endIndex)]))
            value += size
        }
        return slices
    }
    
}

// MARK: - Methods (Integer)
public extension Collection where Element == IntegerLiteralType, Index == Int {
    
    /// YYSwift: Average of all elements in array.
    ///
    /// - Returns: the average of the array's elements.
    func average() -> Double {
        return isEmpty ? 0 : Double(reduce(0, +)) / Double(count)
    }
    
}

// MARK: - Methods (FloatingPoint)
public extension Collection where Element: FloatingPoint {
    
    /// YYSwift: Average of all elements in array.
    ///
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].average() = 3.18
    ///
    /// - Returns: average of the array's elements.
    func average() -> Element {
        guard !isEmpty else { return 0 }
        return reduce(0, +) / Element(count)
    }
    
}
