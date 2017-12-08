//
//  CollectionExtensions.swift
//  YYKitBase
//
//  Created by Phoenix on 2017/10/30.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension Collection {

    public subscript (safeAt index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

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
    
    public func forEachInParallel(_ each: (Self.Iterator.Element) -> Void) {
        let indices = indicesArray()
        
        DispatchQueue.concurrentPerform(iterations: indices.count) { (index) in
            let elementIndex = indices[index]
            each(self[elementIndex])
        }
    }
}

public extension Collection where Index == Int, IndexDistance == Int {
    
    public var random: Iterator.Element? {
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[safeAt: index]
    }
}

public extension Collection where Iterator.Element == Int, Index == Int {

    public var total: Iterator.Element {
        return reduce(0, +)
    }
    
    public func average() -> Element {
        return isEmpty ? 0 : reduce(0, +) / Element(count)
    }
}
