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
    
    public var rgbIntComponents: (red: Int, green: Int, blue: Int) {
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
    
    public var rgbaComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
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
        let a = components[3]
        return (red: r, green: g, blue: b, alpha: a)
    }
    
    public var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    public var hslaComponents: (hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat) {
        let rgba = rgbaComponents
        let hsl = Color.yy.rgb2hsl(rgba.red, rgba.green, rgba.blue)
        return (hue: hsl.hue, saturation: hsl.saturation, lightness: hsl.lightness , alpha: rgba.alpha)
    }
    
    public var cmykaComponents: (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat, alpha: CGFloat) {
        let rgba = rgbaComponents
        let cmyk = Color.yy.rgb2cmyk(rgba.red, rgba.green, rgba.blue)
        return (cyan: cmyk.cyan, magenta: cmyk.magenta, yellow: cmyk.yellow, black: cmyk.black, alpha: rgba.alpha)
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
        let red: CGFloat = 1.0 - self.rgbaComponents.red
        let green: CGFloat = 1.0 - self.rgbaComponents.green
        let blue: CGFloat = 1.0 - self.rgbaComponents.blue
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

extension Color: NamespaceWrappable {}
public extension TypeWrapperProtocol where WrappedType == Color {
    
    public static func rgb2hsl(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> (hue: CGFloat, saturation: CGFloat, lightness: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var l: CGFloat = 0
        Color.yy.RGB2HSL(r, g, b, &h, &s, &l)
        return (h, s, l)
    }
    
    public static func RGB2HSL(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ h: inout CGFloat, _ s: inout CGFloat, _ l: inout CGFloat) {
        var r = r
        var g = g
        var b = b
        Color.clampColorValue(&r)
        Color.clampColorValue(&g)
        Color.clampColorValue(&b)
        var max, min, delta, sum: CGFloat
        max = fmax(r, fmax(g, b))
        min = fmin(r, fmin(g, b))
        delta = max - min
        sum = max + min
        l = sum / 2         // Lightness
        if delta == 0 {     // No Saturation, so Hue is undefined (achromatic)
            h = 0
            s = 0
            return
        }
        s = delta / (sum < 1 ? sum : 2 - sum)        // Saturation
        if (r == max) {
            h = (g - b) / delta / 6                  // color between y & m
        }
        else if (g == max) {
            h = (2 + (b - r) / delta) / 6            // color between c & y
        }
        else {
            h = (4 + (r - g) / delta) / 6            // color between m & c
        }
        if (h < 0) {
            h += 1
        }
    }
    
    public static func hsl2rgb(_ h: CGFloat, _ s: CGFloat, _ l: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        Color.yy.HSL2RGB(h, s, l, &r, &g, &b)
        return (r, g, b)
    }
    
    public static func HSL2RGB(_ h: CGFloat, _ s: CGFloat, _ l: CGFloat, _ r: inout CGFloat, _ g: inout CGFloat, _ b: inout CGFloat) {
        var h = h
        var s = s
        var l = l
        Color.clampColorValue(&h)
        Color.clampColorValue(&s)
        Color.clampColorValue(&l)
        if s == 0 {
            r = l
            g = l
            b = l
            return
        }
        
        var q: CGFloat
        q = (l <= 0.5) ? (l * (1 + s)) : (l + s - (l * s))
        if q <= 0 {
            r = 0
            g = 0
            b = 0
        }
        else {
            r = 0
            g = 0
            b = 0
            var sextant: Int
            var m, sv, fract, vsf, mid1, mid2: CGFloat
            m = l + l - q
            sv = (q - m) / q
            if (h == 1) { h = 0 }
            h *= 6.0
            sextant = h.int
            fract = (h.int - sextant).cgFloat
            vsf = q * sv * fract
            mid1 = m + vsf
            mid2 = q - vsf
            switch (sextant) {
            case 0: r = q; g = mid1; b = m;
            case 1: r = mid2; g = q; b = m;
            case 2: r = m; g = q; b = mid1;
            case 3: r = m; g = mid2; b = q;
            case 4: r = mid1; g = m; b = q;
            case 5: r = q; g = m; b = mid2;
            default: r = 0; g = 0; b = 0;
            }
        }
    }
    
    public static func rgb2hsb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var v: CGFloat = 0
        Color.yy.RGB2HSB(r, g, b, &h, &s, &v)
        return (h, s, v)
    }
    
    public static func RGB2HSB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ h: inout CGFloat, _ s: inout CGFloat, _ v: inout CGFloat) {
        var r = r
        var g = g
        var b = b
        Color.clampColorValue(&r)
        Color.clampColorValue(&g)
        Color.clampColorValue(&b)
        var max, min, delta: CGFloat
        max = fmax(r, fmax(g, b))
        min = fmin(r, fmin(g, b))
        delta = max - min
        
        v = max          // Brightness
        if delta == 0 {  // No Saturation, so Hue is undefined (achromatic)
            h = 0
            s = 0
            return
        }
        
        s = delta / max
        if (r == max) {
            h = (g - b) / delta / 6                  // color between y & m
        }
        else if (g == max) {
            h = (2 + (b - r) / delta) / 6            // color between c & y
        }
        else {
            h = (4 + (r - g) / delta) / 6            // color between m & c
        }
        if (h < 0) {
            h += 1
        }
    }
    
    public static func hsb2rgb(_ h: CGFloat, _ s: CGFloat, _ v: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        Color.yy.HSB2RGB(h, s, v, &r, &g, &b)
        return (r, g, b)
    }
    
    public static func HSB2RGB(_ h: CGFloat, _ s: CGFloat, _ v: CGFloat, _ r: inout CGFloat, _ g: inout CGFloat, _ b: inout CGFloat) {
        var h = h
        var s = s
        var v = v
        Color.clampColorValue(&h)
        Color.clampColorValue(&s)
        Color.clampColorValue(&v)
        if s == 0 {
            r = v
            g = v
            b = v
        }
        else {
            var sextant: Int
            var f, p, q, t: CGFloat
            if h == 1 { h = 0 }
            h *= 6
            sextant = floor(h.double).int
            f = (h.int - sextant).cgFloat
            p = v * (1 - s)
            q = v * (1 - s * f)
            t = v * (1 - s * (1 - f))
            switch (sextant) {
            case 0: r = v; g = t; b = p;
            case 1: r = q; g = v; b = p;
            case 2: r = p; g = v; b = t;
            case 3: r = p; g = q; b = v;
            case 4: r = t; g = p; b = v;
            case 5: r = v; g = p; b = q;
            default: r = 0; g = 0; b = 0;
            }
        }
    }
    
    public static func rgb2cmyk(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat) {
        var c: CGFloat = 0
        var m: CGFloat = 0
        var y: CGFloat = 0
        var k: CGFloat = 0
        Color.yy.RGB2CMYK(r, g, b, &c, &m, &y, &k)
        return (c, m, y, k)
    }
    
    public static func RGB2CMYK(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ c: inout CGFloat, _ m: inout CGFloat, _ y: inout CGFloat, _ k: inout CGFloat) {
        var r = r
        var g = g
        var b = b
        Color.clampColorValue(&r)
        Color.clampColorValue(&g)
        Color.clampColorValue(&b)
        c = 1 - r
        m = 1 - g
        y = 1 - b
        k = fmin(c, fmin(m, y))
        
        if (k == 1) {
            c = 0
            m = 0
            y = 0
        }
        else {
            c = (c - k) / (1 - k)
            m = (m - k) / (1 - k)
            y = (y - k) / (1 - k)
        }
    }
    
    public static func cmyk2rgb(_ c: CGFloat, _ m: CGFloat, _ y: CGFloat, _ k: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        Color.yy.CMYK2RGB(c, m, y, k, &r, &g, &b)
        return (r, g, b)
    }
    
    public static func CMYK2RGB(_ c: CGFloat, _ m: CGFloat, _ y: CGFloat, _ k: CGFloat, _ r: inout CGFloat, _ g: inout CGFloat, _ b: inout CGFloat) {
        var c = c
        var m = m
        var y = y
        var k = k
        Color.clampColorValue(&c)
        Color.clampColorValue(&m)
        Color.clampColorValue(&y)
        Color.clampColorValue(&k)
        
        r = (1 - c) * (1 - k)
        g = (1 - m) * (1 - k)
        b = (1 - y) * (1 - k)
    }
    
    public static func hsb2hsl(_ h: CGFloat, _ s: CGFloat, _ b: CGFloat) -> (hue: CGFloat, saturation: CGFloat, lightness: CGFloat) {
        var hh: CGFloat = 0
        var ss: CGFloat = 0
        var ll: CGFloat = 0
        Color.yy.HSB2HSL(h, s, b, &hh, &ss, &ll)
        return (hh, ss, ll)
    }
    
    public static func HSB2HSL(_ h: CGFloat, _ s: CGFloat, _ b: CGFloat, _ hh: inout CGFloat, _ ss: inout CGFloat, _ ll: inout CGFloat) {
        var h = h
        var s = s
        var b = b
        Color.clampColorValue(&h)
        Color.clampColorValue(&s)
        Color.clampColorValue(&b)
        
        hh = h
        ll = (2 - s) * b / 2
        if ll <= 0.5 {
            ss = s / (2 - s)
        }
        else {
            ss = (s * b) / (2 - (2 - s) * b)
        }
    }
    
    public static func hsl2hsb(_ h: CGFloat, _ s: CGFloat, _ l: CGFloat) -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat) {
        var hh: CGFloat = 0
        var ss: CGFloat = 0
        var bb: CGFloat = 0
        Color.yy.HSL2HSB(h, s, l, &hh, &ss, &bb)
        return (hh, ss, bb)
    }
    
    public static func HSL2HSB(_ h: CGFloat, _ s: CGFloat, _ l: CGFloat, _ hh: inout CGFloat, _ ss: inout CGFloat, _ bb: inout CGFloat) {
        var h = h
        var s = s
        var l = l
        Color.clampColorValue(&h)
        Color.clampColorValue(&s)
        Color.clampColorValue(&l)
        
        hh = h
        if l <= 0.5 {
            bb = (s + 1) * l
            ss = (2 * s) / (s + 1)
        }
        else {
            bb = l + s * (1 - l)
            ss = (2 * s * (1 - l)) / bb
        }
    }
}

public extension Color {
    
    fileprivate static func clampColorValue(_ value: inout CGFloat) {
        value = value < 0 ? 0 : (value > 1 ? 1 : value)
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
    
    public convenience init?(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat = 1) {
        let rgb = Color.yy.hsl2rgb(hue, saturation, lightness)
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: alpha)
    }
    
    public convenience init?(cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat, alpha: CGFloat = 1) {
        let rgb = Color.yy.cmyk2rgb(cyan, magenta, yellow, black)
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: alpha)
    }
    
    public convenience init?(rgbValue: UInt, alpha: CGFloat = 1) {
        self.init(red: CGFloat(((rgbValue & 0xff0000) >> 16) / 255),
                  green: CGFloat(((rgbValue & 0xff00) >> 8) / 255),
                  blue: CGFloat((rgbValue & 0xff) / 255),
                  alpha: alpha)
    }
    
    public convenience init?(rgbaValue: UInt) {
        self.init(red: CGFloat(((rgbaValue & 0xff000000) >> 24) / 255),
                  green: CGFloat(((rgbaValue & 0xff0000) >> 16) / 255),
                  blue: CGFloat((rgbaValue & 0xff00) >> 8 / 255),
                  alpha: CGFloat((rgbaValue & 0xff) / 255))
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
        let hexString = hexString.trimmed.removeAll(" ")
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
        
        guard string.count == 6 else {
            return nil
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
        
        let red: CGFloat = 1.0 - color.rgbaComponents.red
        let green: CGFloat = 1.0 - color.rgbaComponents.green
        let blue: CGFloat = 1.0 - color.rgbaComponents.blue
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

