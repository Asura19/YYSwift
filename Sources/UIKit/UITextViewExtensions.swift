//
//  UITextViewExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/8.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Methods
public extension UITextView {
    
    /// YYSwift: Clear text.
    public func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    
    /// YYSwift: Scroll to the bottom of text view
    public func scrollToBottom() {
        let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
        
    }

    /// YYSwift: Scroll to the top of text view
    public func scrollToTop() {
        let range = NSMakeRange(0, 1)
        scrollRangeToVisible(range)
    }
    
}
#endif
