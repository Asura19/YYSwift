//
//  SignedNumericExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/4.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

// MARK: - Properties
public extension SignedNumeric {
    
    /// YYSwift: String.
    public var string: String {
        return String(describing: self)
    }
    
    /// YYSwift: String with number and current locale currency.
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
