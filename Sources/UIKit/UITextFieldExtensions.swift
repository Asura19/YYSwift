//
//  UITextFieldExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/8.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit


public extension UITextField {

    public enum TextType {
        case emailAddress
        case password
        case generic
    }
    
}

public extension UITextField {
    
    public var textType: TextType {
        get {
            if keyboardType == .emailAddress {
                return .emailAddress
            } else if isSecureTextEntry {
                return .password
            }
            return .generic
        }
        set {
            switch newValue {
            case .emailAddress:
                keyboardType = .emailAddress
                autocorrectionType = .no
                autocapitalizationType = .none
                isSecureTextEntry = false
                placeholder = "Email Address"
                
            case .password:
                keyboardType = .asciiCapable
                autocorrectionType = .no
                autocapitalizationType = .none
                isSecureTextEntry = true
                placeholder = "Password"
                
            case .generic:
                isSecureTextEntry = false
                
            }
        }
    }

    public var isEmpty: Bool {
        return text?.isEmpty == true
    }

    public var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public var hasValidEmail: Bool {
        return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }
    

    @IBInspectable
    public var leftViewTintColor: UIColor? {
        get {
            guard let iconView = leftView as? UIImageView else {
                return nil
            }
            return iconView.tintColor
        }
        set {
            guard let iconView = leftView as? UIImageView else {
                return
            }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
    
    @IBInspectable
    public var rightViewTintColor: UIColor? {
        get {
            guard let iconView = rightView as? UIImageView else {
                return nil
            }
            return iconView.tintColor
        }
        set {
            guard let iconView = rightView as? UIImageView else {
                return
            }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
    
}


public extension UITextField {
    
    public func trim() {
        text = trimmedText
    }

    public func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    
    public func selectAllText() {
        let range = textRange(from: beginningOfDocument, to: endOfDocument)
        selectedTextRange = range
    }
    
    public func setSelectedRange(_ range: Range<Int>) {
        let beginning = beginningOfDocument
        guard let startPosition = position(from: beginning, offset: range.lowerBound),
            let endPostion = position(from: beginning, offset: min(range.upperBound, (text?.count)!)) else {
                return
        }
        let selectionRange = textRange(from: startPosition, to: endPostion)
        selectedTextRange = selectionRange
    }

    public func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }
    
    public func addPaddingLeft(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    public func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        self.leftView = imageView
        self.leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        self.leftViewMode = UITextFieldViewMode.always
    }
    
}
