//
//  CGColorExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/10.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif

public extension CGColor {
    
    #if !os(macOS)
    public var uiColor: UIColor? {
        return UIColor(cgColor: self)
    }
    #endif
    
    #if os(macOS)
    public var nsColor: NSColor? {
        return NSColor(cgColor: self)
    }
    #endif
    
}
