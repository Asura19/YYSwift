//
//  CGColorExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/10.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

// MARK: - Properties
public extension CGColor {
    
    #if canImport(UIKit)
    /// YYSwift: UIColor.
    public var uiColor: UIColor? {
        return UIColor(cgColor: self)
    }
    #endif
    
    #if canImport(Cocoa)
    /// YYSwift: NSColor.
    public var nsColor: NSColor? {
        return NSColor(cgColor: self)
    }
    #endif
    
}
#endif
