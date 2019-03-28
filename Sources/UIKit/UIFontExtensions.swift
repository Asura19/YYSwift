//
//  UIFontExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/20.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Properties
public extension UIFont {
    
    /// YYSwift: Whether the font is bold.
    var isBold: Bool {
        return self.fontDescriptor.symbolicTraits.contains(UIFontDescriptor.SymbolicTraits.traitBold)
    }
    
    /// YYSwift: Whether the font is italic.
    var isItalic: Bool {
        return self.fontDescriptor.symbolicTraits.contains(UIFontDescriptor.SymbolicTraits.traitItalic)
    }
    
    /// YYSwift: YYSwift: Font as monospaced font
    ///
    ///     UIFont.preferredFont(forTextStyle: .body).monospaced
    ///
    var isMonoSpace: Bool {
        return self.fontDescriptor.symbolicTraits.contains(UIFontDescriptor.SymbolicTraits.traitMonoSpace)
    }
    
    /// YYSwift: Whether the font is color glyphs (such as Emoji).
    var isColorGlyphs: Bool {
        return CTFontGetSymbolicTraits(self as CTFont).contains(.traitColorGlyphs)
    }
    
    /// YYSwift: Font weight from -1.0 to 1.0. Regular weight is 0.0.
    var fontWeight: CGFloat {
        let attr = self.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.traits) as! [UIFontDescriptor.TraitKey : Any]
        return attr[.weight] as! CGFloat
    }
    
    /// YYSwift: Creates and returns the CTFont object.
    var ctFont: CTFont {
        return CTFontCreateWithName(self.fontName as CFString, self.pointSize, nil)
    }
    
    /// YYSwift: Creates and returns the CGFont object.
    var cgFont: CGFont? {
        return CGFont.init(self.fontName as CFString)
    }
    
    /// YYSwift: Font as bold font
    var bold: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitBold)!, size: pointSize)
    }
    
    /// YYSwift: Font as italic font
    var italic: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitItalic)!, size: pointSize)
    }
    
    /// YYSwift: Font as bold and italic font
    ///
    /// - Returns: A bold and italic font
    var boldItalic: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits([UIFontDescriptor.SymbolicTraits.traitBold, UIFontDescriptor.SymbolicTraits.traitItalic])!, size: pointSize)
    }
    
    /// YYSwift: Font as normal (no bold/italic/...) font.
    func fontWithNormal() -> UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits([])!, size: pointSize)
    }
}

// MARK: - Methods
public extension UIFont {
    
    /// YYSwift: Load the font from file path. Support format:TTF,OTF.
    ///
    /// - Parameter path: font file's full path
    /// - Returns: true if registration of the fonts was successful, otherwise false.
    static func loadFont(from path: String) -> Bool {
        let url = URL(fileURLWithPath: path)
        let success = CTFontManagerRegisterFontsForURL(url as CFURL, CTFontManagerScope.none, nil)
        return success
    }
    
    /// YYSwift: Unload font from file path.
    ///
    /// - Parameter path: font file's full path
    static func unloadFont(from path: String) {
        let url = URL(fileURLWithPath: path)
        CTFontManagerUnregisterFontsForURL(url as CFURL, CTFontManagerScope.none, nil)
    }
    
    /// YYSwift: Unload font
    ///
    /// - Returns: true if unregistration of the font was successful, otherwise false.
    func unload() -> Bool {
        guard let cgFont = CGFont.init(self.fontName as CFString) else {
            return false
        }
        return CTFontManagerUnregisterGraphicsFont(cgFont, nil)
    }
}

// MARK: - Initializers
public extension UIFont {
    
    convenience init?(cgFont: CGFont, size: CGFloat) {
        guard let name = cgFont.postScriptName else {
            return nil
        }
        self.init(name: name as String, size: size)
    }
    
    convenience init?(ctFont: CTFont) {
        let name = CTFontCopyPostScriptName(ctFont)
        self.init(name: name as String, size: CTFontGetSize(ctFont))
    }
    
    #if os(iOS)
    convenience init?(data: Data) {
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
    convenience init?(data: Data, size: CGFloat) {
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
#endif

