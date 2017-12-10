//
//  BundleExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/10.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation
import UIKit

public extension Bundle {
    
    public class func preferredScales() -> [CGFloat] {
        var scales: [CGFloat]
        let screenScale = UIScreen.main.scale
        if screenScale <= 1 {
            scales = [1, 2, 3]
        }
        else if (screenScale <= 2) {
            scales = [2, 3, 1]
        }
        else {
            scales = [3, 2, 1]
        }
        return scales
    }
    
    public class func pathForScaledResource(withName name: String, ofType ext: String, inDirectory bundlePath: String) -> String? {
        if name.count == 0 { return nil }
        if name.hasSuffix("/") {
            return self.path(forResource:name, ofType: ext, inDirectory: bundlePath)
        }
        var path: String?
        let scales = self.preferredScales()
        for scale in scales {
            let scaledName = ext.count > 0 ? name.appending(nameScale: scale) : name.appending(pathScal: scale)
            path = self.path(forResource: scaledName, ofType: ext, inDirectory: bundlePath)
            if path != nil { break }
        }
        return path!
    }
    
    public func pathForScaledResource(withName name: String, ofType ext: String) -> String? {
        if name.count == 0 { return nil }
        if name.hasSuffix("/") {
            return self.path(forResource:name, ofType: ext)
        }
        var path: String?
        let scales = Bundle.preferredScales()
        for scale in scales {
            let scaledName = ext.count > 0 ? name.appending(nameScale: scale) : name.appending(pathScal: scale)
            path = self.path(forResource: scaledName, ofType: ext)!
            if path != nil { break }
        }
        return path!
    }
    
    public func pathForScaledResource(withName name: String, ofType ext: String, inDirectory subpath: String) -> String? {
        if name.count == 0 { return nil }
        if name.hasSuffix("/") {
            return self.path(forResource:name, ofType: ext, inDirectory: bundlePath)
        }
        var path: String?
        let scales = Bundle.preferredScales()
        for scale in scales {
            let scaledName = ext.count > 0 ? name.appending(nameScale: scale) : name.appending(pathScal: scale)
            path = self.path(forResource: scaledName, ofType: ext, inDirectory: subpath)
            if path != nil { break }
        }
        return path!
    }
}
