//
//  ColorExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/11.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if os(macOS)
    import Cocoa
    public typealias Color = NSColor
#else
    import UIKit
    public typealias Color = UIColor
#endif

#if !os(watchOS)
    import CoreImage
#endif

public extension Color {
    
    public static var random: Color {
        let r = Int(arc4random_uniform(255)).cgFloat
        let g = Int(arc4random_uniform(255)).cgFloat
        let b = Int(arc4random_uniform(255)).cgFloat
        return Color(red: r, green: g, blue: b, alpha: 1)
    }
    
    public var rgbComponents: (red: Int, green: Int, blue: Int) {
        var components: [CGFloat] {
            let c = cgColor.components!
            if c.count == 4 {
                return c
            }
            return [c[0], c[0], c[0], c[1]]
        }
        let r = components[0]
        let g = components[1]
        let b = components[2]
        return (red: Int(r * 255.0), green: Int(g * 255.0), blue: Int(b * 255.0))
    }
    
    public var cgFloatComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var components: [CGFloat] {
            let c = cgColor.components!
            if c.count == 4 {
                return c
            }
            return [c[0], c[0], c[0], c[1]]
        }
        let r = components[0]
        let g = components[1]
        let b = components[2]
        return (red: r, green: g, blue: b)
    }
    
    public var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    public var hexString: String {
        let components: [Int] = {
            let c = cgColor.components!
            let components = c.count == 4 ? c : [c[0], c[0], c[0], c[1]]
            return components.map { Int($0 * 255.0) }
        }()
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }
    
    public var shortHexString: String? {
        let string = hexString.replacingOccurrences(of: "#", with: "")
        let chrs = Array(string)
        guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else { return nil }
        return "#\(chrs[0])\(chrs[2])\(chrs[4])"
    }
    
    public var shortHexOrHexString: String {
        let components: [Int] = {
            let c = cgColor.components!
            let components = c.count == 4 ? c : [c[0], c[0], c[0], c[1]]
            return components.map { Int($0 * 255.0) }
        }()
        let hexString = String(format: "#%02X%02X%02X", components[0], components[1], components[2])
        let string = hexString.replacingOccurrences(of: "#", with: "")
        let chrs = Array(string)
        guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else { return hexString }
        return "#\(chrs[0])\(chrs[2])\(chrs[4])"
    }
    
    public var alpha: CGFloat {
        return cgColor.alpha
    }
    
    #if !os(watchOS)
    public var coreImageColor: CoreImage.CIColor? {
        return CoreImage.CIColor(color: self)
    }
    #endif
    
    public var rgbValue: UInt {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let red = UInt32(r * 255.0)
        let green: UInt32 = UInt32(g * 255.0)
        let blue: UInt32 = UInt32(b * 255.0)
        return UInt((red << 16) + (green << 8) + blue)
    }
    
    public var rgbaValue: UInt {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let red = UInt32(r * 255.0)
        let green = UInt32(g * 255.0)
        let blue = UInt32(b * 255.0)
        let alpha = UInt32(a * 255.0)
        let result = (red << 24) + (green << 16) + (blue << 8) + alpha
        return UInt(result)
    }
}

