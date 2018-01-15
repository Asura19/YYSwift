//
//  UIFontExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/20.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit

// MARK: - Properties
public extension UIFont {
    
    /// YYSwift: Whether the font is bold.
    public var isBold: Bool {
        return self.fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    /// YYSwift: Whether the font is italic.
    public var isItalic: Bool {
        return self.fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
    
    /// YYSwift: YYSwift: Font as monospaced font
    ///
    ///     UIFont.preferredFont(forTextStyle: .body).monospaced
    ///
    public var isMonoSpace: Bool {
        return self.fontDescriptor.symbolicTraits.contains(.traitMonoSpace)
    }
    
    /// YYSwift: Whether the font is color glyphs (such as Emoji).
    public var isColorGlyphs: Bool {
        return CTFontGetSymbolicTraits(self as CTFont).contains(.traitColorGlyphs)
    }
    
    /// YYSwift: Font weight from -1.0 to 1.0. Regular weight is 0.0.
    public var fontWeight: CGFloat {
        let attr = self.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.traits) as! [UIFontDescriptor.TraitKey : Any]
        return attr[.weight] as! CGFloat
    }
    
    /// YYSwift: Creates and returns the CTFont object.
    public var ctFont: CTFont {
        return CTFontCreateWithName(self.fontName as CFString, self.pointSize, nil)
    }
    
    /// YYSwift: Creates and returns the CGFont object.
    public var cgFont: CGFont? {
        return CGFont.init(self.fontName as CFString)
    }
}

// MARK: - Methods
public extension UIFont {
    
    /// YYSwift: Create a bold font from receiver.
    ///
    /// - Returns: A bold font
    public func fontWithBold() -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits(.traitBold)!, size: self.pointSize)
    }
    
    /// YYSwift: Create a italic font from receiver.
    ///
    /// - Returns: A italic font
    public func fontWithItalic() -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits(.traitItalic)!, size: self.pointSize)
    }
    
    /// YYSwift: Create a bold and italic font from receiver.
    ///
    /// - Returns: A bold and italic font
    public func fontWithBoldItalic() -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic])!, size: self.pointSize)
    }
    
    /// YYSwift: Create a normal (no bold/italic/...) font from receiver.
    ///
    /// - Returns: A normal font without bold/italic...
    public func fontWithNormal() -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits([])!, size: self.pointSize)
    }
    
    /// YYSwift: Load the font from file path. Support format:TTF,OTF.
    ///
    /// - Parameter path: font file's full path
    /// - Returns: true if registration of the fonts was successful, otherwise false.
    public static func loadFont(from path: String) -> Bool {
        let url = URL(fileURLWithPath: path)
        let success = CTFontManagerRegisterFontsForURL(url as CFURL, CTFontManagerScope.none, nil)
        return success
    }
    
    /// YYSwift: Unload font from file path.
    ///
    /// - Parameter path: font file's full path
    public static func unloadFont(from path: String) {
        let url = URL(fileURLWithPath: path)
        CTFontManagerUnregisterFontsForURL(url as CFURL, CTFontManagerScope.none, nil)
    }
    
    /// YYSwift: Unload font
    ///
    /// - Returns: true if unregistration of the font was successful, otherwise false.
    public func unload() -> Bool {
        guard let cgFont = CGFont.init(self.fontName as CFString) else {
            return false
        }
        return CTFontManagerUnregisterGraphicsFont(cgFont, nil)
    }
}

// MARK: - Initializers
public extension UIFont {
    
    public convenience init?(cgFont: CGFont, size: CGFloat) {
        guard let name = cgFont.postScriptName else {
            return nil
        }
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
        guard let name = cgFont.postScriptName else {
            return nil
        }
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
        guard let name = cgFont.postScriptName else {
            return nil
        }
        self.init(name: name as String, size: size)
    }
    #endif
}


