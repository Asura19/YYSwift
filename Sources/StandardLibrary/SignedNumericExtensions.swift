//
//  SignedNumericExtensions.swift
//  YYKitBase
//
//  Created by Phoenix on 2017/12/4.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension SignedNumeric {
    
    public var string: String {
        return String(describing: self)
    }
    
    public var asLocaleCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        guard let number = self as? NSNumber else {
            return ""
        }
        return formatter.string(from: number) ?? ""
    }
}
