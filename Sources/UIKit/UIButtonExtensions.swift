//
//  UIButtonExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/20.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit

// MARK: - Properties
public extension UIButton {
    
    /// Image of disabled state for button; also inspectable from Storyboard.
    @IBInspectable
    public var imageForDisabled: UIImage? {
        get {
            return image(for: .disabled)
        }
        set {
            setImage(newValue, for: .disabled)
        }
    }
    
    /// YYSwift: Image of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable
    public var imageForHighlighted: UIImage? {
        get {
            return image(for: .highlighted)
        }
        set {
            setImage(newValue, for: .highlighted)
        }
    }
    
    /// YYSwift: Image of normal state for button; also inspectable from Storyboard.
    @IBInspectable
    public var imageForNormal: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }
    
    /// YYSwift: Image of selected state for button; also inspectable from Storyboard.
    @IBInspectable
    public var imageForSelected: UIImage? {
        get {
            return image(for: .selected)
        }
        set {
            setImage(newValue, for: .selected)
        }
    }
    
    /// YYSwift: Title color of disabled state for button; also inspectable from Storyboard.
    @IBInspectable public var titleColorForDisabled: UIColor? {
        get {
            return titleColor(for: .disabled)
        }
        set {
            setTitleColor(newValue, for: .disabled)
        }
    }
    
    /// YYSwift: Title color of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable
    public var titleColorForHighlighted: UIColor? {
        get {
            return titleColor(for: .highlighted)
        }
        set {
            setTitleColor(newValue, for: .highlighted)
        }
    }
    
    /// YYSwift: Title color of normal state for button; also inspectable from Storyboard.
    @IBInspectable
    public var titleColorForNormal: UIColor? {
        get {
            return titleColor(for: .normal)
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }
    
    /// YYSwift: Title color of selected state for button; also inspectable from Storyboard.
    @IBInspectable
    public var titleColorForSelected: UIColor? {
        get {
            return titleColor(for: .selected)
        }
        set {
            setTitleColor(newValue, for: .selected)
        }
    }
    
    /// YYSwift: Title of disabled state for button; also inspectable from Storyboard.
    @IBInspectable
    public var titleForDisabled: String? {
        get {
            return title(for: .disabled)
        }
        set {
            setTitle(newValue, for: .disabled)
        }
    }
    
    /// YYSwift: Title of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable
    public var titleForHighlighted: String? {
        get {
            return title(for: .highlighted)
        }
        set {
            setTitle(newValue, for: .highlighted)
        }
    }
    
    /// YYSwift: Title of normal state for button; also inspectable from Storyboard.
    @IBInspectable
    public var titleForNormal: String? {
        get {
            return title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
    
    /// YYSwift: Title of selected state for button; also inspectable from Storyboard.
    @IBInspectable
    public var titleForSelected: String? {
        get {
            return title(for: .selected)
        }
        set {
            setTitle(newValue, for: .selected)
        }
    }
}

// MARK: - Methods
public extension UIButton {
    
    private var states: [UIControlState] {
        return [.normal, .selected, .highlighted, .disabled]
    }
    
    /// YYSwift: Set image for all states.
    ///
    /// - Parameter image: UIImage.
    public func setImageForAllStates(_ image: UIImage) {
        states.forEach { self.setImage(image, for: $0) }
    }
    
    /// YYSwift: Set title color for all states.
    ///
    /// - Parameter color: UIColor.
    public func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { self.setTitleColor(color, for: $0) }
    }
    
    /// YYSwift: Set title for all states.
    ///
    /// - Parameter title: title string.
    public func setTitleForAllStates(_ title: String) {
        states.forEach { self.setTitle(title, for: $0) }
    }
    
}
