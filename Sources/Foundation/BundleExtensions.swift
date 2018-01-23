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
    
    /// YYSwift: An array of NSNumber objects, shows the best order for path scale search.
    /// e.g. iPhone3GS:[1,2,3] iPhone5:[2,3,1]  iPhone6 Plus:[3,2,1]
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
    
    /// YYSwift: Returns the full pathname for the resource file identified by the specified
    /// name and extension and residing in a given bundle directory. It first search
    /// the file with current screen's scale (such as @2x), then search from higher
    /// scale to lower scale.
    ///
    /// - Parameters:
    ///   - name: The name of a resource file contained in the directory
    ///           specified by bundlePath.
    ///   - ext: If extension is an empty string or nil, the extension is
    ///          assumed not to exist and the file is the first file encountered that exactly matches name.
    ///   - bundlePath: The path of a top-level bundle directory. This must be a
    ///                 valid path. For example, to specify the bundle directory for a Mac app, you
    ///                 might specify the path /Applications/MyApp.app.
    /// - Returns: The full pathname for the resource file or nil if the file could not be
    ///            located. This method also returns nil if the bundle specified by the bundlePath
    ///            parameter does not exist or is not a readable directory.
    public class func pathForScaledResource(withName name: String,
                                            ofType ext: String,
                                            inDirectory bundlePath: String) -> String? {
        if name.count == 0 { return nil }
        if name.hasSuffix("/") {
            return self.path(forResource:name, ofType: ext, inDirectory: bundlePath)
        }
        var path: String?
        let scales = self.preferredScales()
        for scale in scales {
            let scaledName = ext.count > 0 ? name.appending(nameScale: scale) : name.appending(pathScale: scale)
            path = self.path(forResource: scaledName, ofType: ext, inDirectory: bundlePath)
            if path != nil { break }
        }
        return path!
    }
    
    /// YYSwift: Returns the full pathname for the resource identified by the specified name and
    /// file extension. It first search the file with current screen's scale (such as @2x),
    /// then search from higher scale to lower scale.
    ///
    /// - Parameters:
    ///   - name: The name of the resource file. If name is an empty string or
    ///           nil, returns the first file encountered of the supplied type.
    ///   - ext: If extension is an empty string or nil, the extension is
    ///          assumed not to exist and the file is the first file encountered that exactly matches name.
    /// - Returns: The full pathname for the resource file or nil if the file could not be located.
    public func pathForScaledResource(withName name: String, ofType ext: String) -> String? {
        if name.count == 0 { return nil }
        if name.hasSuffix("/") {
            return self.path(forResource:name, ofType: ext)
        }
        var path: String?
        let scales = Bundle.preferredScales()
        for scale in scales {
            let scaledName = ext.count > 0 ? name.appending(nameScale: scale) : name.appending(pathScale: scale)
            path = self.path(forResource: scaledName, ofType: ext)!
            if path != nil { break }
        }
        return path!
    }
    
    /// YYSwift: Returns the full pathname for the resource identified by the specified name and
    /// file extension and located in the specified bundle subdirectory. It first search
    /// the file with current screen's scale (such as @2x), then search from higher
    /// scale to lower scale.
    ///
    /// - Parameters:
    ///   - name: The name of the resource file.
    ///   - ext: If extension is an empty string or nil, all the files in
    ///          subpath and its subdirectories are returned. If an extension is provided the
    ///          subdirectories are not searched.
    ///   - subpath: The name of the bundle subdirectory. Can be nil.
    /// - Returns: The full pathname for the resource file or nil if the file could not be located.
    public func pathForScaledResource(withName name: String, ofType ext: String, inDirectory subpath: String) -> String? {
        if name.count == 0 { return nil }
        if name.hasSuffix("/") {
            return self.path(forResource:name, ofType: ext, inDirectory: bundlePath)
        }
        var path: String?
        let scales = Bundle.preferredScales()
        for scale in scales {
            let scaledName = ext.count > 0 ? name.appending(nameScale: scale) : name.appending(pathScale: scale)
            path = self.path(forResource: scaledName, ofType: ext, inDirectory: subpath)
            if path != nil { break }
        }
        return path!
    }
}
