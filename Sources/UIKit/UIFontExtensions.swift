//
//  UIFontExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/20.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit

public extension UIFont {
    
    public var isBold: Bool {
        return self.fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    public var isItalic: Bool {
        return self.fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
    
    public var isMonoSpace: Bool {
        return self.fontDescriptor.symbolicTraits.contains(.traitMonoSpace)
    }
    
    public var isColorGlyphs: Bool {
        return CTFontGetSymbolicTraits(self as CTFont).contains(.traitColorGlyphs)
    }
    
    public var fontWeight: CGFloat {
        let attr = self.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.traits) as! [UIFontDescriptor.TraitKey : Any]
        return attr[.weight] as! CGFloat
    }
    
    public var ctFont: CTFont {
        return CTFontCreateWithName(self.fontName as CFString, self.pointSize, nil)
    }
    
    public var cgFont: CGFont? {
        return CGFont.init(self.fontName as CFString)
    }
    
    public func fontWithBold() -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits(.traitBold)!, size: self.pointSize)
    }
    
    public func fontWithItalic() -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits(.traitItalic)!, size: self.pointSize)
    }
    
    public func fontWithBoldItalic() -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic])!, size: self.pointSize)
    }
    
    public func fontWithNormal() -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits([])!, size: self.pointSize)
    }
}

public extension UIFont {
    
    public convenience init?(cgFont: CGFont, size: CGFloat) {
        guard let name = cgFont.postScriptName else { return nil }
        self.init(name: name as String, size: size)
    }
    
    public convenience init?(ctFont: CTFont) {
        let name = CTFontCopyPostScriptName(ctFont)
        self.init(name: name as String, size: CTFontGetSize(ctFont))
    }
    
    #if os(iOS)
    public convenience init?(data: Data) {
        guard let provider = CGDataProvider(data: data as CFData) else {
            return nil
        }
        guard let cgFont = CGFont.init(provider) else {
            return nil
        }
        guard CTFontManagerRegisterGraphicsFont(cgFont, nil) else {
            return nil
        }
        guard let name = cgFont.postScriptName else { return nil }
        self.init(name: name as String, size: UIFont.systemFontSize)
    }
    #endif
    
    #if os(tvOS) || os(watchOS)
    public convenience init?(data: Data, size: CGFloat) {
        guard let provider = CGDataProvider(data: data as CFData) else {
            return nil
        }
        guard let cgFont = CGFont.init(provider) else {
            return nil
        }
        guard CTFontManagerRegisterGraphicsFont(cgFont, nil) else {
            return nil
        }
        guard let name = cgFont.postScriptName else { return nil }
        self.init(name: name as String, size: size)
    }
    #endif
}

public extension UIFont {
    
    public static func loadFont(from path: String) -> Bool {
        let url = URL(fileURLWithPath: path)
        let success = CTFontManagerRegisterFontsForURL(url as CFURL, CTFontManagerScope.none, nil)
        return success
    }
    
    public static func unloadFont(from path: String) {
        let url = URL(fileURLWithPath: path)
        CTFontManagerUnregisterFontsForURL(url as CFURL, CTFontManagerScope.none, nil)
    }
    
    public func unload() -> Bool {
        guard let cgFont = CGFont.init(self.fontName as CFString) else {
            return false
        }
        return CTFontManagerUnregisterGraphicsFont(cgFont, nil)
    }

}

