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
    
    public var complementary: Color {
        let red: CGFloat = 1.0 - self.cgFloatComponents.red
        let green: CGFloat = 1.0 - self.cgFloatComponents.green
        let blue: CGFloat = 1.0 - self.cgFloatComponents.blue
        return Color.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public static func blend(_ color1: Color, intensity1: CGFloat = 0.5, with color2: Color, intensity2: CGFloat = 0.5) -> Color {

        let total = intensity1 + intensity2
        let ratio1 = intensity1 / total
        let ratio2 = intensity2 / total
        
        guard ratio1 > 0 else { return color2 }
        guard ratio2 > 0 else { return color1 }
        
        let components1: [CGFloat] = {
            let c = color1.cgColor.components!
            return c.count == 4 ? c : [c[0], c[0], c[0], c[1]]
        }()
        let components2: [CGFloat] = {
            let c = color2.cgColor.components!
            return c.count == 4 ? c : [c[0], c[0], c[0], c[1]]
        }()
        
        let r1 = components1[0]
        let r2 = components2[0]
        
        let g1 = components1[1]
        let g2 = components2[1]
        
        let b1 = components1[2]
        let b2 = components2[2]
        
        let a1 = color1.cgColor.alpha
        let a2 = color2.cgColor.alpha
        
        let r = r1 * ratio1 + r2 * ratio2
        let g = g1 * ratio1 + g2 * ratio2
        let b = b1 * ratio1 + b2 * ratio2
        let a = a1 * ratio1 + a2 * ratio2
        
        return Color(red: r, green: g, blue: b, alpha: a)
        
    }
    
    public func blend(withColor color: Color) -> Color {
        return Color.blend(self, intensity1: 0.5, with: color, intensity2: 0.5)
    }
    
    public func lighten(by percentage: CGFloat = 0.2) -> Color {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return Color(red: min(r + percentage, 1.0),
                     green: min(g + percentage, 1.0),
                     blue: min(b + percentage, 1.0),
                     alpha: a)
    }
    
    public func darken(by percentage: CGFloat = 0.2) -> Color {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return Color(red: max(r - percentage, 0),
                     green: max(g - percentage, 0),
                     blue: max(b - percentage, 0),
                     alpha: a)
    }
}

public extension Color {
    
    public convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    public convenience init?(hex: Int, transparency: CGFloat = 1) {
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
    
    public convenience init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        
        guard let hexValue = Int(string, radix: 16) else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
    
    public convenience init?(complementaryFor color: Color) {
        
        let red: CGFloat = 1.0 - color.cgFloatComponents.red
        let green: CGFloat = 1.0 - color.cgFloatComponents.green
        let blue: CGFloat = 1.0 - color.cgFloatComponents.blue
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

