//
//  UITextFieldExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/8.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

// MARK: - Enums
public extension UITextField {

    /// YYSwift: UITextField text type.
    ///
    /// - emailAddress: UITextField is used to enter email addresses.
    /// - password: UITextField is used to enter passwords.
    /// - generic: UITextField is used to enter generic text.
    public enum TextType {
        case emailAddress
        case password
        case generic
    }
}

public extension UITextField {
    
    /// YYSwift: Set textField for common text types.
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

    /// YYSwift: Check if text field is empty.
    public var isEmpty: Bool {
        return text?.isEmpty == true
    }

    /// YYSwift: Return text with no spaces or new lines in beginning and end.
    public var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// YYSwift: Check if textFields text is a valid email format.
    ///
    ///     textField.text = "john@doe.com"
    ///     textField.hasValidEmail -> true
    ///
    ///     textField.text = "YYSwift"
    ///     textField.hasValidEmail -> false
    ///
    public var hasValidEmail: Bool {
        return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }
    
    /// YYSwift: Left view tint color.
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
    
    /// YYSwift: Right view tint color.
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

// MARK: - Methods
public extension UITextField {
    
    /// Set text trimmed
    public func trimmed() {
        text = trimmedText
    }

    /// YYSwift: Clear text.
    public func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    
    /// YYSwift: Set all text selected.
    public func selectAllText() {
        let range = textRange(from: beginningOfDocument, to: endOfDocument)
        selectedTextRange = range
    }
    
    /// YYSwift: Set text in range selected.
    ///
    /// - Parameter range: The range of selected text in a document.
    public func setSelectedRange(_ range: Range<Int>) {
        let beginning = beginningOfDocument
        guard let startPosition = position(from: beginning, offset: range.lowerBound),
            let endPostion = position(from: beginning, offset: min(range.upperBound, (text?.count)!)) else {
                return
        }
        let selectionRange = textRange(from: startPosition, to: endPostion)
        selectedTextRange = selectionRange
    }

    /// YYSwift: Set placeholder text color.
    ///
    /// - Parameter color: placeholder text color.
    public func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    /// YYSwift: Add padding to the left of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the left of the textfield rect.
    public func addPaddingLeft(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    /// YYSwift: Add padding to the left of the textfield rect.
    ///
    /// - Parameters:
    ///   - image: left image
    ///   - padding: amount of padding between icon and the left of textfield
    public func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        self.leftView = imageView
        self.leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        self.leftViewMode = UITextField.ViewMode.always
    }
    
}
