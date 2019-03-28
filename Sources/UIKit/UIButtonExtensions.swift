//
//  UIButtonExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/20.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Properties
public extension UIButton {
    
    /// Image of disabled state for button; also inspectable from Storyboard.
    @IBInspectable
    var imageForDisabled: UIImage? {
        get {
            return image(for: UIControl.State.disabled)
        }
        set {
            setImage(newValue, for: UIControl.State.disabled)
        }
    }
    
    /// YYSwift: Image of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable
    var imageForHighlighted: UIImage? {
        get {
            return image(for: UIControl.State.highlighted)
        }
        set {
            setImage(newValue, for: UIControl.State.highlighted)
        }
    }
    
    /// YYSwift: Image of normal state for button; also inspectable from Storyboard.
    @IBInspectable
    var imageForNormal: UIImage? {
        get {
            return image(for: UIControl.State.normal)
        }
        set {
            setImage(newValue, for: UIControl.State.normal)
        }
    }
    
    /// YYSwift: Image of selected state for button; also inspectable from Storyboard.
    @IBInspectable
    var imageForSelected: UIImage? {
        get {
            return image(for: UIControl.State.selected)
        }
        set {
            setImage(newValue, for: UIControl.State.selected)
        }
    }
    
    /// YYSwift: Title color of disabled state for button; also inspectable from Storyboard.
    @IBInspectable var titleColorForDisabled: UIColor? {
        get {
            return titleColor(for: UIControl.State.disabled)
        }
        set {
            setTitleColor(newValue, for: UIControl.State.disabled)
        }
    }
    
    /// YYSwift: Title color of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleColorForHighlighted: UIColor? {
        get {
            return titleColor(for: UIControl.State.highlighted)
        }
        set {
            setTitleColor(newValue, for: UIControl.State.highlighted)
        }
    }
    
    /// YYSwift: Title color of normal state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleColorForNormal: UIColor? {
        get {
            return titleColor(for: UIControl.State.normal)
        }
        set {
            setTitleColor(newValue, for: UIControl.State.normal)
        }
    }
    
    /// YYSwift: Title color of selected state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleColorForSelected: UIColor? {
        get {
            return titleColor(for: UIControl.State.selected)
        }
        set {
            setTitleColor(newValue, for: UIControl.State.selected)
        }
    }
    
    /// YYSwift: Title of disabled state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleForDisabled: String? {
        get {
            return title(for: UIControl.State.disabled)
        }
        set {
            setTitle(newValue, for: UIControl.State.disabled)
        }
    }
    
    /// YYSwift: Title of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleForHighlighted: String? {
        get {
            return title(for: UIControl.State.highlighted)
        }
        set {
            setTitle(newValue, for: UIControl.State.highlighted)
        }
    }
    
    /// YYSwift: Title of normal state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleForNormal: String? {
        get {
            return title(for: UIControl.State.normal)
        }
        set {
            setTitle(newValue, for: UIControl.State.normal)
        }
    }
    
    /// YYSwift: Title of selected state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleForSelected: String? {
        get {
            return title(for: UIControl.State.selected)
        }
        set {
            setTitle(newValue, for: UIControl.State.selected)
        }
    }
}

// MARK: - Methods
public extension UIButton {
    
    private var states: [UIControl.State] {
        return [UIControl.State.normal, UIControl.State.selected, UIControl.State.highlighted, UIControl.State.disabled]
    }
    
    /// YYSwift: Set image for all states.
    ///
    /// - Parameter image: UIImage.
    func setImageForAllStates(_ image: UIImage) {
        states.forEach { self.setImage(image, for: $0) }
    }
    
    /// YYSwift: Set title color for all states.
    ///
    /// - Parameter color: UIColor.
    func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { self.setTitleColor(color, for: $0) }
    }
    
    /// YYSwift: Set title for all states.
    ///
    /// - Parameter title: title string.
    func setTitleForAllStates(_ title: String) {
        states.forEach { self.setTitle(title, for: $0) }
    }
    
}
#endif
