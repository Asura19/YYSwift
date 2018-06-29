//
//  UINavigationBarExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/8.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Methods
public extension UINavigationBar {
    
    /// YYSwift: Set Navigation Bar title, title color and font.
    ///
    /// - Parameters:
    ///   - font: title font
    ///   - color: title text color (default is .black).
    public func setTitleFont(_ font: UIFont, color: UIColor = .black) {
        var attrs: [NSAttributedString.Key: Any] = [:]
        attrs[NSAttributedString.Key.font] = font
        attrs[NSAttributedString.Key.foregroundColor] = color
        titleTextAttributes = attrs
    }
    
    /// YYSwift: Make navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    public func makeTransparent(withTint tint: UIColor = .white) {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
        tintColor = tint
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: tint]
    }
    
    /// YYSwift: Set navigationBar background and text colors
    ///
    /// - Parameters:
    ///   - background: backgound color
    ///   - text: text color
    public func setColors(background: UIColor, text: UIColor) {
        isTranslucent = false
        backgroundColor = background
        barTintColor = background
        setBackgroundImage(UIImage(), for: .default)
        tintColor = text
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: text]
    }
}
#endif
