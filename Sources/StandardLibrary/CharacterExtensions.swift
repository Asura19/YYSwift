//
//  CharacterExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/11/24.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension Character {
    
    public var isNumber: Bool {
        return Int(String(self)) != nil
    }
    
    public var isLetter: Bool {
        return String(self).rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    public var isUppercased: Bool {
        return String(self) == String(self).uppercased()
    }

    public var isLowercased: Bool {
        return String(self) == String(self).lowercased()
    }
    
    public var isWhiteSpace: Bool {
        return String(self) == " "
    }
    
    public var isNewline: Bool {
        return String(self) == "\n"
    }
    
    public var int: Int? {
        return Int(String(self))
    }
 
    public var string: String {
        return String(self)
    }
    
    public var lowercased: Character {
        return String(self).lowercased().first!
    }
    
    public var uppercased: Character {
        return String(self).uppercased().first!
    }
    
    public static func * (lhs: Character, rhs: Int) -> String {
        guard rhs > 0 else {
            return ""
        }
        return String(repeating: String(lhs), count: rhs)
    }
    
    public static func * (lhs: Int, rhs: Character) -> String {
        guard lhs > 0 else {
            return ""
        }
        return String(repeating: String(rhs), count: lhs)
    }
}
