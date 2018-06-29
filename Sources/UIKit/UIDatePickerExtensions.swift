//
//  UIDatePickerExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/5.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Properties
public extension UIDatePicker {
    
    /// YYSwift: Text color of UIDatePicker.
    public var textColor: UIColor? {
        set {
            setValue(newValue, forKeyPath: "textColor")
        }
        get {
            return value(forKeyPath: "textColor") as? UIColor
        }
    }
    
}
#endif
