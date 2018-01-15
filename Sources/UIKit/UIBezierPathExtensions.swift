//
//  UIBezierPathExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/10.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

// MARK: - Methods
public extension UIBezierPath {
    
    /// YYSwift: Creates and returns a new UIBezierPath object initialized with the text glyphs generated from the specified font.
    ///
    /// - Parameters:
    ///   - text: The text to generate glyph path.
    ///   - font: The font to generate glyph path.
    /// - Returns: A new path object with the text and font, or nil if an error occurs.
    public static func bezierPathWithText(_ text: String, font: UIFont) -> UIBezierPath? {
        let ctFont = font.ctFont
        let attrString = NSAttributedString.init(string: text, attributes: [kCTFontAttributeName as NSAttributedStringKey: ctFont])
        let line = CTLineCreateWithAttributedString(attrString as CFAttributedString)
        let cgPath = CGMutablePath()
        let runs = CTLineGetGlyphRuns(line)
        for iRun in 0..<CFArrayGetCount(runs) {
            let run = unsafeBitCast(CFArrayGetValueAtIndex(runs, iRun), to: CTRun.self)
            let CTFontName = unsafeBitCast(kCTFontAttributeName, to: UnsafeRawPointer.self)
            let runFont = unsafeBitCast(CFDictionaryGetValue(CTRunGetAttributes(run), CTFontName), to: CTFont.self)
            for iGlyph in 0..<CTRunGetGlyphCount(run) {
                let glyphRange = CFRangeMake(iGlyph, 1)
                var glyph = CGGlyph()
                var position = CGPoint()
                CTRunGetGlyphs(run, glyphRange, &glyph)
                CTRunGetPositions(run, glyphRange, &position)
                
                if let glyphPath = CTFontCreatePathForGlyph(runFont, glyph, nil) {
                    let transform = CGAffineTransform.init(translationX: position.x, y: position.y)
                    cgPath.addPath(glyphPath, transform: transform)
                }
            }
        }
        let path = UIBezierPath.init(cgPath: cgPath)
        let boundingBox = cgPath.boundingBoxOfPath
        path.apply(CGAffineTransform.init(scaleX: 1.0, y: -1.0))
        path.apply(CGAffineTransform.init(translationX: 0.0, y: boundingBox.size.height))
        return path
    }
}
