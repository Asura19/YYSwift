//
//  UIDatePickerExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/5.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

public extension UIDatePicker {
    
    public var textColor: UIColor? {
        set {
            setValue(newValue, forKeyPath: "textColor")
        }
        get {
            return value(forKeyPath: "textColor") as? UIColor
        }
    }
    
}
