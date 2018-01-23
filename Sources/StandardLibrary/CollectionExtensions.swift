//
//  CollectionExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/10/30.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension Collection {

    /// YYSwift: Safe protects the array from out of bounds by use of optional.
    ///
    ///        let arr = [1, 2, 3, 4, 5]
    ///        arr[safeAt: 1] -> 2
    ///        arr[safeAt: 10] -> nil
    ///
    /// - Parameter index: index of element to access element.
    public subscript (safeAt index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// MARK: - Methods
public extension Collection {
    
    private func indicesArray() -> [Self.Index] {
        var indices: [Self.Index] = []
        var anIndex = startIndex
        while anIndex != endIndex {
            indices.append(anIndex)
            anIndex = index(after: anIndex)
        }
        return indices
    }
    
    /// YYSwift: Performs `each` closure for each element of collection in parallel.
    ///
    ///     array.forEachInParallel { item in
    ///         print(item)
    ///     }
    ///
    /// - Parameter each: closure to run for each element.
    public func forEachInParallel(_ each: (Self.Iterator.Element) -> Void) {
        let indices = indicesArray()
        
        DispatchQueue.concurrentPerform(iterations: indices.count) { (index) in
            let elementIndex = indices[index]
            each(self[elementIndex])
        }
    }
}

public extension Collection where Index == Int, IndexDistance == Int {
    
    /// YYSwift: Random item from array.
    public var random: Iterator.Element? {
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[safeAt: index]
    }
}

// MARK: - Methods (Integer)
public extension Collection where Iterator.Element == Int, Index == Int {

    
    /// YYSwift: Return sum result.
    public var total: Iterator.Element {
        return reduce(0, +)
    }
    
    /// YYSwift: Average of all elements in array.
    ///
    /// - Returns: the average of the array's elements.
    public func average() -> Element {
        return isEmpty ? 0 : reduce(0, +) / Element(count)
    }
}
