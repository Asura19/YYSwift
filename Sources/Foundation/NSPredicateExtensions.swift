//
//  NSPredicateExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/9.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

// MARK: - Properties
public extension NSPredicate {
    
    /// YYSwift: Returns a new predicate formed by NOT-ing the predicate.
    public var not: NSCompoundPredicate {
        return NSCompoundPredicate(notPredicateWithSubpredicate: self)
    }
}

// MARK: - Methods
public extension NSPredicate {
    
    /// YYSwift: Returns a new predicate formed by AND-ing the argument to the predicate.
    ///
    /// - Parameter predicate: NSPredicate
    /// - Returns: NSCompoundPredicate
    public func and(_ predicate: NSPredicate) -> NSCompoundPredicate {
        return NSCompoundPredicate(andPredicateWithSubpredicates: [self, predicate])
    }
    
    /// YYSwift: Returns a new predicate formed by OR-ing the argument to the predicate.
    ///
    /// - Parameter predicate: NSPredicate
    /// - Returns: NSCompoundPredicate
    public func or(_ predicate: NSPredicate) -> NSCompoundPredicate {
        return NSCompoundPredicate(orPredicateWithSubpredicates: [self, predicate])
    }
}
