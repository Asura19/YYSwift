//
//  UISearchBarExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/8.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

// MARK: - Properties
public extension UISearchBar {
    
    /// YYSwift: Text field inside search bar (if applicable).
    public var textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }
    
    /// YYSwift: Text with no spaces or new lines in beginning and end (if applicable).
    public var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - Methods
public extension UISearchBar {
    
    /// YYSwift: Clear text.
    public func clear() {
        text = ""
    }
    
    /// YYSwift: Set text with no spaces or new lines in beginning and end (if applicable).
    public func trimmed() {
        text = trimmedText
    }
}
