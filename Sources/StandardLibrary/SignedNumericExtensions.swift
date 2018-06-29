//
//  SignedNumericExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/4.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties
public extension SignedNumeric {
    
    /// YYSwift: String.
    public var string: String {
        return String(describing: self)
    }
    
    #if canImport(Foundation)
    /// YYSwift: String with number and current locale currency.
    public var asLocaleCurrency: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        // swiftlint:disable next force_cast
        return formatter.string(from: self as! NSNumber)
    }
    #endif
}
