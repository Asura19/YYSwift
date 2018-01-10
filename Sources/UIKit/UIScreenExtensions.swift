//
//  UIScreenExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/10.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

public extension UIScreen {
    
    public static func screenScale() -> CGFloat {
        var screenScale: CGFloat = 0
        if Thread.isMainThread {
            screenScale = UIScreen.main.scale
        }
        else {
            DispatchQueue.main.sync {
                screenScale = UIScreen.main.scale
            }
        }
        return screenScale
    }
    
    public var currentBounds: CGRect {
        return self.boudsForOrientation(UIApplication.shared.statusBarOrientation)
    }
    
    public func boudsForOrientation(_ orientation: UIInterfaceOrientation) -> CGRect {
        var bounds = self.bounds
        if orientation.isLandscape {
            swap(&bounds.size.width, &bounds.size.height)
        }
        return bounds
    }
    
    public var sizeInPixel: CGSize {
        var size = CGSize.zero
        
        if UIScreen.main.isEqual(self) {
            guard let model = UIDevice.current.machineModel else { return size }
            if model.hasPrefix("iPhone") {
                if model == "iPhone7,1" ||
                    model == "iPhone8,2" ||
                    model == "iPhone9,2" ||
                    model == "iPhone9,4" ||
                    model == "iPhone10,2" ||
                    model == "iPhone10,5" {
                    return CGSize(width: 1080, height: 1920)
                }
            }
            if model.hasPrefix("iPad") {
                if model == "iPad6,7" ||
                    model == "iPad6,8" ||
                    model == "iPad7,1" ||
                    model == "iPad7,2" {
                    return CGSize(width: 2048, height: 2732)
                }
                else if model == "iPad7,3" ||
                    model == "iPad7,4" {
                    return CGSize(width: 1668, height: 2224)
                }
            }
        }
        
        if size == .zero {
            size = self.nativeBounds.size
        }
        return size
    }
    
    public var pixelsPerInch: CGFloat {
        if !UIScreen.main.isEqual(self) {
            return 326
        }
        
        let dict: Dictionary<String, CGFloat> = [
            "iPod1,1" : 163, //"iPod touch 1",
            "iPod2,1" : 163, //"iPod touch 2",
            "iPod3,1" : 163, //"iPod touch 3",
            "iPod4,1" : 326, //"iPod touch 4",
            "iPod5,1" : 326, //"iPod touch 5",
            "iPod7,1" : 326, //"iPod touch 6",
            
            "iPhone1,1" : 163, //"iPhone 1G",
            "iPhone1,2" : 163, //"iPhone 3G",
            "iPhone2,1" : 163, //"iPhone 3GS",
            "iPhone3,1" : 326, //"iPhone 4 (GSM)",
            "iPhone3,2" : 326, //"iPhone 4",
            "iPhone3,3" : 326, //"iPhone 4 (CDMA)",
            "iPhone4,1" : 326, //"iPhone 4S",
            "iPhone5,1" : 326, //"iPhone 5",
            "iPhone5,2" : 326, //"iPhone 5",
            "iPhone5,3" : 326, //"iPhone 5c",
            "iPhone5,4" : 326, //"iPhone 5c",
            "iPhone6,1" : 326, //"iPhone 5s",
            "iPhone6,2" : 326, //"iPhone 5s",
            "iPhone7,1" : 401, //"iPhone 6 Plus",
            "iPhone7,2" : 326, //"iPhone 6",
            "iPhone8,1" : 326, //"iPhone 6s",
            "iPhone8,2" : 401, //"iPhone 6s Plus",
            "iPhone8,4" : 326, //"iPhone SE",
            "iPhone9,1" : 326, //"iPhone 7",
            "iPhone9,2" : 401, //"iPhone 7 Plus",
            "iPhone9,3" : 326, //"iPhone 7",
            "iPhone9,4" : 401, //"iPhone 7 Plus",
            "iPhone10,1" : 326, //"iPhone 8",
            "iPhone10,4" : 326, //"iPhone 8",
            "iPhone10,2" : 401, //"iPhone 8 Plus",
            "iPhone10,5" : 401, //"iPhone 8 Plus",
            "iPhone10,3" : 458, //"iPhone X",
            "iPhone10,6" : 458, //"iPhone X",
            
            "iPad1,1" : 132, //"iPad 1",
            "iPad2,1" : 132, //"iPad 2 (WiFi)",
            "iPad2,2" : 132, //"iPad 2 (GSM)",
            "iPad2,3" : 132, //"iPad 2 (CDMA)",
            "iPad2,4" : 132, //"iPad 2",
            "iPad2,5" : 264, //"iPad mini 1",
            "iPad2,6" : 264, //"iPad mini 1",
            "iPad2,7" : 264, //"iPad mini 1",
            "iPad3,1" : 324, //"iPad 3 (WiFi)",
            "iPad3,2" : 324, //"iPad 3 (4G)",
            "iPad3,3" : 324, //"iPad 3 (4G)",
            "iPad3,4" : 324, //"iPad 4",
            "iPad3,5" : 324, //"iPad 4",
            "iPad3,6" : 324, //"iPad 4",
            "iPad4,1" : 324, //"iPad Air",
            "iPad4,2" : 324, //"iPad Air",
            "iPad4,3" : 324, //"iPad Air",
            "iPad4,4" : 264, //"iPad mini 2",
            "iPad4,5" : 264, //"iPad mini 2",
            "iPad4,6" : 264, //"iPad mini 2",
            "iPad4,7" : 264, //"iPad mini 3",
            "iPad4,8" : 264, //"iPad mini 3",
            "iPad4,9" : 264, //"iPad mini 3",
            "iPad5,1" : 264, //"iPad mini 4",
            "iPad5,2" : 264, //"iPad mini 4",
            "iPad5,3" : 324, //"iPad Air 2",
            "iPad5,4" : 324, //"iPad Air 2",
            "iPad6,3" : 324, //"iPad Pro (9.7 inch)",
            "iPad6,4" : 324, //"iPad Pro (9.7 inch)",
            "iPad6,7" : 264, //"iPad Pro (12.9 inch)",
            "iPad6,8" : 264, //"iPad Pro (12.9 inch)",
            "iPad6,11" : 264, //"iPad 5",
            "iPad6,12" : 264, //"iPad 5",
            "iPad7,1" : 264, //"iPad Pro 2 (12.9 inch)",
            "iPad7,2" : 264, //"iPad Pro 2 (12.9 inch)",
            "iPad7,3" : 264, //"iPad Pro (10.5 inch)",
            "iPad7,4" : 264, //"iPad Pro (10.5 inch)",
        ]
        guard let model = UIDevice.current.machineModel else { return 326 }
        return dict[model] ?? 326
    }
}
