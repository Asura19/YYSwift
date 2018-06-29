//
//  CharacterExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/11/24.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties
public extension Character {
    
    /// YYSwift: Check if character is number.
    ///
    ///     Character("1").isNumber -> true
    ///     Character("a").isNumber -> false
    ///
    public var isNumber: Bool {
        return Int(String(self)) != nil
    }
    
    /// YYSwift: Check if character is a letter.
    ///
    ///     Character("4").isLetter -> false
    ///     Character("a").isLetter -> true
    ///
    public var isLetter: Bool {
        return String(self).rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// YYSwift: Check if character is uppercased.
    ///
    ///    Character("a").isUppercased -> false
    ///    Character("A").isUppercased -> true
    ///
    public var isUppercased: Bool {
        return String(self) == String(self).uppercased()
    }

    /// YYSwift: Check if character is lowercased.
    ///
    ///    Character("a").isLowercased -> true
    ///    Character("A").isLowercased -> false
    ///
    public var isLowercased: Bool {
        return String(self) == String(self).lowercased()
    }
    
    /// YYSwift: Check if character is white space.
    ///
    ///    Character(" ").isWhiteSpace -> true
    ///    Character("A").isWhiteSpace -> false
    ///
    public var isWhiteSpace: Bool {
        return String(self) == " "
    }
    
    /// YYSwift: Check if character is new line.
    ///
    ///    Character("\n").isWhiteSpace -> true
    ///    Character("A").isWhiteSpace -> false
    ///
    public var isNewline: Bool {
        return String(self) == "\n"
    }
    
    /// YYSwift: Integer from character (if applicable).
    ///
    ///    Character("1").int -> 1
    ///    Character("A").int -> nil
    ///
    public var int: Int? {
        return Int(String(self))
    }
 
    /// YYSwift: String from character.
    ///
    ///    Character("a").string -> "a"
    ///
    public var string: String {
        return String(self)
    }
    
    /// YYSwift: Return the character lowercased.
    ///
    ///    Character("A").lowercased -> Character("a")
    ///
    public var lowercased: Character {
        return String(self).lowercased().first!
    }
    
    /// YYSwift: Return the character uppercased.
    ///
    ///    Character("a").uppercased -> Character("A")
    ///
    public var uppercased: Character {
        return String(self).uppercased().first!
    }
    
}

// MARK: - Methods
public extension Character {
    
    #if canImport(Foundation)
    /// YYSwift: Random character.
    ///
    ///    Character.random() -> k
    ///
    /// - Returns: A random character.
    public static func randomAlphanumeric() -> Character {
        let allCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomNumber = Int(arc4random_uniform(UInt32(allCharacters.count)))
        let randomIndex = allCharacters.index(allCharacters.startIndex, offsetBy: randomNumber)
        return allCharacters[randomIndex]
    }
    #endif
}


// MARK: - Operators
public extension Character {
    
    /// YYSwift: Repeat character multiple times.
    ///
    ///     Character("-") * 10 -> "----------"
    ///
    /// - Parameters:
    ///   - lhs: character to repeat.
    ///   - rhs: number of times to repeat character.
    /// - Returns: string with character repeated n times.
    public static func * (lhs: Character, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: String(lhs), count: rhs)
    }
    
    /// YYSwift: Repeat character multiple times.
    ///
    ///     10 * Character("-") -> "----------"
    ///
    /// - Parameters:
    ///   - lhs: number of times to repeat character.
    ///   - rhs: character to repeat.
    /// - Returns: string with character repeated n times.
    public static func * (lhs: Int, rhs: Character) -> String {
        guard lhs > 0 else { return "" }
        return String(repeating: String(rhs), count: lhs)
    }
}

