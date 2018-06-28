//
//  StringExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/4.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation
#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif

// MARK: - Properties
public extension String {
    
    #if os(macOS) || os(iOS)
    /// YYSwift: Returns a lowercase String for md2 hash.
    public var md2String: String? {
        return self.utf8Data?.md2String
    }
    
    /// YYSwift: Returns a lowercase String for md4 hash.
    public var md4String: String? {
        return self.utf8Data?.md4String
    }
    
    /// YYSwift: Returns a lowercase String for md5 hash.
    public var md5String: String? {
        return self.utf8Data?.md5String
    }
    
    /// YYSwift: Returns a lowercase String for sha1 hash.
    public var sha1String: String? {
        return self.utf8Data?.sha1String
    }
    
    /// YYSwift: Returns a lowercase String for sha224 hash.
    public var sha224String: String? {
        return self.utf8Data?.sha224String
    }
    
    /// YYSwift: Returns a lowercase String for sha256 hash.
    public var sha256String: String? {
        return self.utf8Data?.sha256String
    }
    
     /// YYSwift: Returns a lowercase String for sha384 hash.
    public var sha384String: String? {
        return self.utf8Data?.sha384String
    }
    
    /// YYSwift: Returns a lowercase String for sha512 hash.
    public var sha512String: String? {
        return self.utf8Data?.sha384String
    }
    
    /// YYSwift: Returns a lowercase String for hmac using algorithm md5 with key.
    ///
    /// - Parameter key: The hmac key.
    /// - Returns: a lowercase String for hmac using algorithm md5 with key.
    public func hmacMD5StringWithKey(_ key: String) -> String? {
        return self.utf8Data?.hmacMD5StringWithKey(key)
    }
    
    /// YYSwift: Returns a lowercase String for hmac using algorithm sha1 with key.
    ///
    /// - Parameter key: The hmac key.
    /// - Returns: a lowercase String for hmac using algorithm sha1 with key.
    public func hmacSHA1StringWithKey(_ key: String) -> String? {
        return self.utf8Data?.hmacSHA1StringWithKey(key)
    }
    
    /// YYSwift: Returns a lowercase String for hmac using algorithm sha224 with key.
    ///
    /// - Parameter key: The hmac key.
    /// - Returns: a lowercase String for hmac using algorithm sha224 with key.
    public func hmacSHA224StringWithKey(_ key: String) -> String? {
        return self.utf8Data?.hmacSHA224StringWithKey(key)
    }
    
    /// YYSwift: Returns a lowercase String for hmac using algorithm sha256 with key.
    ///
    /// - Parameter key: The hmac key.
    /// - Returns: a lowercase String for hmac using algorithm sha256 with key.
    public func hmacSHA256StringWithKey(_ key: String) -> String? {
        return self.utf8Data?.hmacSHA256StringWithKey(key)
    }

    /// YYSwift: Returns a lowercase String for hmac using algorithm sha384 with key.
    ///
    /// - Parameter key: The hmac key.
    /// - Returns: a lowercase String for hmac using algorithm sha384 with key.
    public func hmacSHA384StringWithKey(_ key: String) -> String? {
        return self.utf8Data?.hmacSHA384StringWithKey(key)
    }
    
    /// YYSwift: Returns a lowercase String for hmac using algorithm sha512 with key.
    ///
    /// - Parameter key: The hmac key.
    /// - Returns: a lowercase String for hmac using algorithm sha512 with key.
    public func hmacSHA512StringWithKey(_ key: String) -> String? {
        return self.utf8Data?.hmacSHA512StringWithKey(key)
    }
    #endif
    
    /// YYSwift: Returns an Data using UTF-8 encoding.
    public var utf8Data: Data? {
        return self.data(using: .utf8)
    }
    
    /// YYSwift: String decoded from base64 (if applicable).
    ///
    ///     "SGVsbG8gV29ybGQh".base64Decoded = Optional("Hello World!")
    ///
    public var base64Decoded: String? {
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }
    
    /// YYSwift: String encoded in base64 (if applicable).
    ///
    ///     "Hello World!".base64Encoded -> Optional("SGVsbG8gV29ybGQh")
    ///
    public var base64Encoded: String? {
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    /// YYSwift: CamelCase of string.
    ///
    ///     "sOme vAriable naMe".camelCased -> "someVariableName"
    ///
    public var camelCased: String {
        let source = lowercased()
        let first = String(source.first!)
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            return first + rest
        }
        let rest = String(source.dropFirst())
        return first + rest
    }
    
    /// YYSwift: Check if string contains one or more emojis.
    ///
    ///     "Hello 😀".containEmoji -> true
    ///
    public var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F, // Emoticons
            0x2100...0x27BF, // Misc symbols and Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// YYSwift: Whether string contain string of a character set.
    ///
    /// - Parameter characterSet: a character set
    /// - Returns: true if contains.
    public func contain(characterSet: CharacterSet) -> Bool {
        return rangeOfCharacter(from: characterSet) != nil
    }
    
    /// YYSwift: First character of string (if applicable).
    ///
    ///     "Hello".firstCharacterAsString -> Optional("H")
    ///     "".firstCharacterAsString -> nil
    ///
    public var firstCharacterAsString: String? {
        guard let first = first else {
            return nil
        }
        return String(first)
    }
    
    /// YYSwift: Last character of string (if applicable).
    ///
    ///     "Hello".lastCharacterAsString -> Optional("o")
    ///     "".lastCharacterAsString -> nil
    ///
    public var lastCharacterAsString: String? {
        guard let last = last else {
            return nil
        }
        return String(last)
    }
    
    /// YYSwift: Check if string contains one or more letters.
    ///
    ///     "123abc".hasLetters -> true
    ///     "123".hasLetters -> false
    ///
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// YYSwift: Check if string contains one or more numbers.
    ///
    ///     "abcd".hasNumbers -> false
    ///     "123abc".hasNumbers -> true
    ///
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// YYSwift: Check if string contains only letters.
    ///
    ///     "abc".isAlphabetic -> true
    ///     "123abc".isAlphabetic -> false
    ///
    public var isAlphabetic: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasLetters && !hasNumbers
    }
    
    /// YYSwift: Check if string contains only numbers.
    ///
    ///     "123".isNumeric -> true
    ///     "abc".isNumeric -> false
    ///
    public var isNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return  !hasLetters && hasNumbers
    }
    
    /// YYSwift: Check if string contains at least one letter and one number.
    ///
    ///     // useful for passwords
    ///     "123abc".isAlphaNumeric -> true
    ///     "abc".isAlphaNumeric -> false
    ///
    public var isAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    
    /// YYSwift: Check if string is valid email format.
    ///
    ///     "john@doe.com".isEmail -> true
    ///
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    }
    
    /// YYSwift: Check if string is a valid URL.
    ///
    ///     "https://google.com".isValidUrl -> true
    ///
    public var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /// YYSwift: Check if string is a valid schemed URL.
    ///
    ///     "https://google.com".isValidSchemedUrl -> true
    ///     "google.com".isValidSchemedUrl -> false
    ///
    public var isValidSchemedUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return url.scheme != nil
    }
    
    /// YYSwift: Check if string is a valid https URL.
    ///
    ///     "https://google.com".isValidHttpsUrl -> true
    ///
    public var isValidHttpsUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return url.scheme == "https"
    }
    
    /// YYSwift: Check if string is a valid http URL.
    ///
    ///     "http://google.com".isValidHttpUrl -> true
    ///
    public var isValidHttpUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return url.scheme == "http"
    }
    
    /// YYSwift: Check if string is a valid file URL.
    ///
    ///     "file://Documents/file.txt".isValidFileUrl -> true
    ///
    public var isValidFileUrl: Bool {
        return URL(string: self)?.isFileURL ?? false
    }
    
    /// YYSwift: Latinized string.
    ///
    ///     "Hèllö Wórld!".latinized -> "Hello World!"
    ///
    public var latinized: String {
        return folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    /// YYSwift: String with no spaces or new lines in beginning and end.
    ///
    ///     "   hello  \n".trimmed -> "hello"
    ///
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// YYSwift: Bool value from string (if applicable).
    ///
    ///     "1".bool -> true
    ///     "False".bool -> false
    ///     "Hello".bool = nil
    ///
    public var bool: Bool? {
        let selfLowercased = trimmed.lowercased()
        if selfLowercased == "true"
            || selfLowercased == "1"
            || selfLowercased == "yes" {
            return true
        }
        else if selfLowercased == "false"
            || selfLowercased == "0"
            || selfLowercased == "no" {
            return false
        }
        return nil
    }
    
    /// YYSwift: Date object from "yyyy-MM-dd" formatted string.
    ///
    ///     "2007-06-29".date -> Optional(Date)
    ///
    public var date: Date? {
        let selfLowercased = trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    /// YYSwift: Date object from "yyyy-MM-dd HH:mm:ss" formatted string.
    ///
    ///     "2007-06-29 14:23:09".dateTime -> Optional(Date)
    ///
    public var dateTime: Date? {
        let selfLowercased = trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    /// YYSwift: Integer value from string (if applicable).
    ///
    ///     "101".int -> 101
    ///
    public var int: Int? {
        return Int(self)
    }
    
    /// YYSwift: URL from string (if applicable).
    ///
    ///     "https://google.com".url -> URL(string: "https://google.com")
    ///     "not url".url -> nil
    ///
    public var url: URL? {
        return URL(string: self)
    }
    
    /// YYSwift: Readable string from a URL string.
    ///
    ///     "it's%20easy%20to%20decode%20strings".urlDecoded -> "it's easy to decode strings"
    ///
    public var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
    /// YYSwift: URL escaped string.
    ///
    ///     "it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
    ///
    public var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    /// YYSwift: String without spaces and new lines.
    ///
    ///     "   \n Swifter   \n  Swift  ".withoutSpacesAndNewLines -> "YYSwift"
    ///
    public var withoutSpacesAndNewLines: String {
        return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
    
    /// YYSwift: Check if the given string contains only white spaces
    public var isWhitespace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

}

public extension String {
    
    /// YYSwift: Verify if string matches the regex pattern.
    ///
    /// - Parameter pattern: Pattern to verify.
    /// - Returns: true if string matches the pattern.
    public func matches(pattern: String) -> Bool {
        return range(of: pattern,
                     options: String.CompareOptions.regularExpression,
                     range: nil,
                     locale: nil) != nil
    }
    
    /// YYSwift: Match the regular expression, and executes a given block using each object in the matches.
    ///
    /// - Parameters:
    ///   - regex: The regular expression
    ///   - options: The matching options to report.
    ///   - execute: The closure to apply to elements in the array of matches.
    ///     The closure takes four arguments:
    ///     match: The match substring.
    ///     matchRange: The matching options.
    ///     stop: A reference to a Bool value. The closure can set the value
    ///           to true to stop further processing of the array. The stop
    ///           argument is an out-only argument. You should only ever set
    ///           this Bool to true within the Block.
    public func enumerate(regex: String,
                          options: NSRegularExpression.Options,
                          _ execute: (String, CountableRange<Int>, Bool) -> Void) {
        if regex.count == 0 {
            return
        }
        guard let pattern = try? NSRegularExpression.init(pattern: regex, options: options) else {
            return
        }
        pattern.enumerateMatches(in: self, options: [], range: NSMakeRange(0, self.count)) { (result, flags, stop) in
            let start = index(startIndex, offsetBy: (result?.range.lowerBound)!)
            let end = index(startIndex, offsetBy: (result?.range.upperBound)!)
            let range = (result?.range.lowerBound)!..<(result?.range.upperBound)!
            execute(String(self[start..<end]), range, stop.pointee.boolValue)
        }
    }
    
    /// YYSwift: Replace the match string with replacement
    ///
    /// - Parameters:
    ///   - regex: The regular expression
    ///   - options: The matching options to report.
    ///   - replacement: replacement string
    /// - Returns: a string that removed the matched
    public func replace(regex: String,
                        options: NSRegularExpression.Options,
                        with replacement: String) -> String {
        if regex.count == 0 {
            return self
        }
        guard let pattern = try? NSRegularExpression.init(pattern: regex, options: options) else {
            return self
        }
        return pattern.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: replacement)
    }
    
    /// YYSwift: Remove all the matched string
    ///
    /// - Parameter target: expression string to remove
    /// - Returns: a string that removed the target
    public func removeAll(_ target: String) -> String {
        return replacingOccurrences(of: target, with: "")
    }

    /// YYSwift: Float value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Float value from given string.
    public func float(locale: Locale = .current) -> Float? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self) as? Float
    }
    
    /// YYSwift: Double value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Double value from given string.
    public func double(locale: Locale = .current) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self) as? Double
    }
    
    /// YYSwift: CGFloat value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional CGFloat value from given string.
    public func cgFloat(locale: Locale = .current) -> CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self) as? CGFloat
    }
    
    /// YYSwift: Array of strings separated by new lines.
    ///
    ///        "Hello\ntest".lines() -> ["Hello", "test"]
    ///
    /// - Returns: Strings separated by new lines.
    public func lines() -> [String] {
        var result: [String] = []
        enumerateLines { line, _ in
            result.append(line)
        }
        return result
    }
    
    /// YYSwift: The most common character in string.
    ///
    ///     "This is a test, since e is appearing everywhere e should be the common character".mostCommonCharacter() -> "e"
    ///
    /// - Returns: The most common character.
    public func mostCommonCharacter() -> String {
        let mostCommon = withoutSpacesAndNewLines.reduce(into: [Character : Int]()) {
            let count = $0[$1] ?? 0
            $0[$1] = count + 1
        }.max { $0.1 < $1.1 }?.0
        guard let character = mostCommon else {
            return ""
        }
        return String(character)
    }
    
    /// YYSwift: Array with unicodes for all characters in a string.
    ///
    ///     "YYSwift".unicodeArray -> [83, 119, 105, 102, 116, 101, 114, 83, 119, 105, 102, 116]
    ///
    /// - Returns: The unicodes for all characters in a string.
    public func unicodeArray() -> [Int] {
        return unicodeScalars.map({ $0.hashValue })
    }
    
    /// YYSwift: an array of all words in a string
    ///
    ///     "Swift is amazing".words() -> ["Swift", "is", "amazing"]
    ///
    /// - Returns: The words contained in a string.
    public func words() -> [String] {
        // https://stackoverflow.com/questions/42822838
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = components(separatedBy: chararacterSet)
        return comps.filter { !$0.isEmpty }
    }
    
    /// YYSwift: Count of words in a string.
    ///
    ///     "Swift is amazing".wordsCount() -> 3
    ///
    /// - Returns: The count of words contained in a string.
    public func wordCount() -> Int {
        // https://stackoverflow.com/questions/42822838
        return words().count
    }
    
    /// YYSwift: Safely subscript string with index.
    ///
    ///     "Hello World!"[3] -> "l"
    ///     "Hello World!"[20] -> nil
    ///
    /// - Parameter i: index.
    public subscript(_ i: Int) -> String? {
        guard i >= 0 && i < count else {
            return nil
        }
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    /// YYSwift: Safely subscript string within a half-open range.
    ///
    ///     "Hello World!"[6..<11] -> "World"
    ///     "Hello World!"[21..<110] -> nil
    ///
    /// - Parameter range: Half-open range.
    public subscript(_ range: CountableRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else {
            return nil
        }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else {
            return nil
        }
        return String(self[lowerIndex..<upperIndex])
    }
    
    /// YYSwift: Safely subscript string within a closed range.
    ///
    ///     "Hello World!"[6...11] -> "World!"
    ///     "Hello World!"[21...110] -> nil
    ///
    /// - Parameter range: Closed range.
    public subscript(_ range: ClosedRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else {
            return nil
        }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else {
            return nil
        }
        return String(self[lowerIndex..<upperIndex])
    }
    
    #if os(iOS) || os(macOS)
    /// YYSwift: Copy string to global pasteboard.
    ///
    ///     "SomeText".copyToPasteboard() // copies "SomeText" to pasteboard
    ///
    public func copyToPasteboard() {
        #if os(iOS)
            UIPasteboard.general.string = self
        #elseif os(macOS)
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(self, forType: .string)
        #endif
    }
    #endif
    
    /// YYSwift: Converts string format to CamelCase.
    ///
    ///     var str = "sOme vaRiabLe Name"
    ///     str.camelize()
    ///     print(str) // prints "someVariableName"
    ///
    public mutating func camelize() {
        self = camelCased
    }
    
    /// YYSwift: Check if string contains only unique characters.
    public func hasUniqueCharacters() -> Bool {
        guard self.count > 0 else {
            return false
        }
        var uniqueChars = Set<String>()
        for char in self {
            if uniqueChars.contains(String(char)) {
                return false
            }
            uniqueChars.insert(String(char))
        }
        return true
    }
    
    /// YYSwift: Check if string contains one or more instance of substring.
    ///
    ///     "Hello World!".contain("O") -> false
    ///     "Hello World!".contain("o", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string contains one or more instance of substring.
    public func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
    
    /// YYSwift: Count of substring in string.
    ///
    ///     "Hello World!".count(of: "o") -> 2
    ///     "Hello World!".count(of: "L", caseSensitive: false) -> 3
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: count of appearance of substring in string.
    public func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return lowercased().components(separatedBy: string.lowercased()).count - 1
        }
        return components(separatedBy: string).count - 1
    }
    
    /// YYSwift: Check if string starts with substring.
    ///
    ///     "hello World".starts(with: "h") -> true
    ///     "hello World".starts(with: "H", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string starts with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string starts with substring.
    public func starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }
    
    /// YYSwift: Check if string ends with substring.
    ///
    ///     "Hello World!".ends(with: "!") -> true
    ///     "Hello World!".ends(with: "WoRld!", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string ends with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string ends with substring.
    public func ends(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }
    
    /// YYSwift: Latinize string.
    ///
    ///     var str = "Hèllö Wórld!"
    ///     str.latinize()
    ///     print(str) // prints "Hello World!"
    ///
    public mutating func latinize() {
        self = latinized
    }
    
    /// YYSwift: Random string of given length.
    ///
    ///     String.random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
    ///
    /// - Parameter length: number of characters in string.
    /// - Returns: random string of given length.
    public static func random(ofLength length: Int) -> String {
        guard length > 0 else {
            return ""
        }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            let randomIndex = arc4random_uniform(UInt32(base.count))
            let randomCharacter = base[Int(randomIndex)]
            randomString.append(randomCharacter!)
        }
        return randomString
    }
    
    /// YYSwift: Sliced string from a start index with length.
    ///
    ///     "Hello World".slicing(from: 6, length: 5) -> "World"
    ///
    /// - Parameters:
    ///   - i: string index the slicing should start from.
    ///   - length: amount of characters to be sliced after given index.
    /// - Returns: sliced substring of length number of characters (if applicable) (example: "Hello World".slicing(from: 6, length: 5) -> "World")
    public func slicing(from i: Int, length: Int) -> String? {
        guard length >= 0, i >= 0, i < count  else {
            return nil
        }
        guard i.advanced(by: length) <= count else {
            return self[i..<count]
        }
        guard length > 0 else {
            return ""
        }
        return self[i..<i.advanced(by: length)]
    }
    
    /// YYSwift: Slice given string from a start index with length (if applicable).
    ///
    ///     var str = "Hello World"
    ///     str.slice(from: 6, length: 5)
    ///     print(str) // prints "World"
    ///
    /// - Parameters:
    ///   - i: string index the slicing should start from.
    ///   - length: amount of characters to be sliced after given index.
    public mutating func slice(from i: Int, length: Int) {
        
        if let str = self.slicing(from: i, length: length) {
            self = String(str)
        }
    }
    
    /// YYSwift: Slice given string from a start index to an end index (if applicable).
    ///
    ///     var str = "Hello World"
    ///     str.slice(from: 6, to: 11)
    ///     print(str) // prints "World"
    ///
    /// - Parameters:
    ///   - start: string index the slicing should start from.
    ///   - end: string index the slicing should end at.
    public mutating func slice(from start: Int, to end: Int) {
        guard end >= start else {
            return
        }
        
        if let str = self[start..<end] {
            self = str
        }
    }
    
    /// YYSwift: Slice given string from a start index (if applicable).
    ///
    ///     var str = "Hello World"
    ///     str.slice(from: 6)
    ///     print(str) // prints "World"
    ///
    /// - Parameter i: string index the slicing should start from.
    public mutating func slice(from i: Int) {
        guard i < count else {
            return
        }
        
        if let str = self[i..<count] {
            self = str
        }
    }
    
    /// YYSwift: Slice given string to a end index (if applicable).
    ///
    ///     var str = "Hello World"
    ///     str.slice(to: 5)
    ///     print(str) // prints "Hello"
    ///
    /// - Parameter i: string index the slicing should start from.
    public mutating func slice(to i: Int) {
        guard i > 0 else {
            return
        }
        
        if let str = self[0..<i] {
            self = str
        }
    }

    /// YYSwift: Date object from string of date format.
    ///
    ///     "2017-01-15".date(withFormat: "yyyy-MM-dd") -> Date set to Jan 15, 2017
    ///     "not date string".date(withFormat: "yyyy-MM-dd") -> nil
    ///
    /// - Parameter format: date format.
    /// - Returns: Date object from string (if applicable).
    public func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    /// YYSwift: Removes spaces and new lines in beginning and end of string.
    ///
    ///     var str = "  \n Hello World \n\n\n"
    ///     str.trim()
    ///     print(str) // prints "Hello World"
    ///
    public mutating func trim() {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// YYSwift: Truncate string (cut it to a given number of characters).
    ///
    ///     var str = "This is a very long sentence"
    ///     str.truncate(toLength: 14)
    ///     print(str) // prints "This is a very..."
    ///
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string (default is "...").
    public mutating func truncate(toLength length: Int, trailing: String? = "...") {
        guard length > 0 else {
            return
        }
        if count > length {
            self = self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
        }
    }
    
    /// YYSwift: Truncated string (limited to a given number of characters).
    ///
    ///     "This is a very long sentence".truncated(toLength: 14) -> "This is a very..."
    ///     "Short sentence".truncated(toLength: 14) -> "Short sentence"
    ///
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string.
    /// - Returns: truncated string (this is an extr...).
    public func truncated(toLength length: Int, trailing: String? = "...") -> String {
        guard 1..<count ~= length else {
            return self
        }
        return self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
    }
    
    /// YYSwift: Convert URL string to readable string.
    ///
    ///     var str = "it's%20easy%20to%20decode%20strings"
    ///     str.urlDecode()
    ///     print(str) // prints "it's easy to decode strings"
    ///
    public mutating func urlDecode() {
        if let decoded = removingPercentEncoding {
            self = decoded
        }
    }
    
    /// YYSwift: Escape string.
    ///
    ///     var str = "it's easy to encode strings"
    ///     str.urlEncode()
    ///     print(str) // prints "it's%20easy%20to%20encode%20strings"
    ///
    public mutating func urlEncode() {
        if let encoded = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            self = encoded
        }
    }
}

// MARK: - Operators
public extension String {
    
    /// YYSwift: Repeat string multiple times.
    ///
    ///     'bar' * 3 -> "barbarbar"
    ///
    /// - Parameters:
    ///   - lhs: string to repeat.
    ///   - rhs: number of times to repeat character.
    /// - Returns: new string with given string repeated n times.
    public static func * (lhs: String, rhs: Int) -> String {
        guard rhs > 0 else {
            return ""
        }
        return String(repeating: lhs, count: rhs)
    }
    
    /// YYSwift: Repeat string multiple times.
    ///
    ///     3 * 'bar' -> "barbarbar"
    ///
    /// - Parameters:
    ///   - lhs: number of times to repeat character.
    ///   - rhs: string to repeat.
    /// - Returns: new string with given string repeated n times.
    public static func * (lhs: Int, rhs: String) -> String {
        guard lhs > 0 else {
            return ""
        }
        return String(repeating: rhs, count: lhs)
    }
    
}

// MARK: - Iinitializer
public extension String {
    
    public init?(base64: String) {
        guard let str = base64.base64Decoded else {
            return nil
        }
        self.init(str)
    }
    
    public init(randomOfLength length: Int) {
        self = String.random(ofLength: length)
    }
    
}


// MARK: - UUID string
public extension String {
    public static func uuid() -> String {
        return UUID().uuidString
    }
}

// MARK: - NSAttributedString extensions
public extension String {
    
    #if !os(tvOS) && !os(watchOS)
    /// YYSwift: Bold string.
    public var bold: NSAttributedString {
        #if os(macOS)
            return NSMutableAttributedString(string: self, attributes: [.font: NSFont.boldSystemFont(ofSize: NSFont.systemFontSize)])
        #else
            return NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
        #endif
    }
    #endif
    
    /// YYSwift: Underlined string
    public var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    /// YYSwift: Strikethrough string.
    
    public var strikethrough: NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    #if os(iOS)
    /// YYSwift: Italic string.
    public var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    #endif
    
    #if os(macOS)
    /// YYSwift: Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    public func colored(with color: NSColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
    
    #else
    /// YYSwift: Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    public func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    #endif
    
    #if os(iOS) || os(tvOS) || os(watchOS)
    
    /// Returns the size of the string if it were rendered with the specified constraints.
    ///
    /// - Parameters:
    ///   - font: The font to use for computing the string size.
    ///   - size: The maximum acceptable size for the string. This value is
    ///           used to calculate where line breaks and wrapping would occur.
    ///   - lineBreakMode: The line break options for computing the size of the string.
    ///                    For a list of possible values, see NSLineBreakMode.
    /// - Returns: The width and height of the resulting string's bounding box.
    ///            These values may be rounded up to the nearest whole number.
    public func size(forFont font: UIFont,
                     size: CGSize,
                     lineBreakMode: NSLineBreakMode) -> CGSize {
        var result: CGSize
        var attr: [NSAttributedString.Key: Any] = [:]
        attr[NSAttributedString.Key.font] = font
        if lineBreakMode != .byWordWrapping {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode
            attr[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        let rect = NSString(string: self).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attr, context: nil)
        result = rect.size
        return result
    }
    
    
  
    #endif
}


public extension String {

    /// YYSwift: NSString from a string.
    public var nsString: NSString {
        return NSString(string: self)
    }

    /// YYSwift: NSString lastPathComponent.
    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }

    /// YYSwift: NSString pathExtension.
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }

    /// YYSwift: NSString deletingLastPathComponent.
    public var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }

    /// YYSwift: NSString deletingPathExtension.
    public var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    /// YYSwift: NSString pathComponents.
    public var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    
    /// YYSwift: NSString appendingPathComponent(str: String)
    ///
    /// - Parameter str: the path component to append to the receiver.
    /// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
    public func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }

    /// YYSwift: NSString appendingPathExtension(str: String)
    ///
    /// - Parameter str: The extension to append to the receiver.
    /// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
    public func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
    
    /// Add scale modifier to the file name (without path extension),
    /// From "name" to "name@2x".
    ///
    /// - Parameter scale: Resource scale.
    /// - Returns: String by add scale modifier, or just return if it's not end with file name.
    public func appending(nameScale scale: CGFloat) -> String {
        if fabs(scale - 1) <= CGFloat.ulpOfOne
            || self.count == 0
            || self.hasSuffix("/") {
            return self
        }
        return self.appendingFormat("@%@x", String(describing: scale))
    }
    
    /// Add scale modifier to the file path (with path extension),
    /// From "name.png" to "name@2x.png".
    ///
    /// - Parameter scale: Resource scale.
    /// - Returns: String by add scale modifier, or just return if it's not end with file name.
    public func appending(pathScale scale: CGFloat) -> String {
        if fabs(scale - 1) <= CGFloat.ulpOfOne ||
            self.count == 0 ||
            self.hasSuffix("/") {
            return self
        }
        let ext = self.pathExtension
        guard !ext.isEmpty else {
            return self.appending(nameScale: scale)
        }
        
        let scaleStr = String.init(format: "@%@x.%@", NSNumber(value: Float(scale)), ext)
        return self.replacingOccurrences(of: "." + ext, with: scaleStr, options: [], range: nil)
    }
    
    /// Return the path scale.
    public func pathScale() -> CGFloat {
        if self.count == 0 || self.hasSuffix("/") {
            return 1
        }
        var scale: CGFloat = 1
        let name = deletingPathExtension
        name.enumerate(regex: "@[0-9]+\\.?[0-9]*x$", options: .anchorsMatchLines) { (match, range, stop) in
            var scaleString = match
            scaleString = String(scaleString.dropLast())
            scaleString = String(scaleString.dropFirst())
            scale = scaleString.cgFloat()!
        }
        return scale
    }
    
    /// Returns an Dictionary/Array which is decoded from receiver.
    /// Returns nil if an error occurs.
    ///
    /// - Returns: e.g. String: @"{"name":"a","count":2}"  => Dictionary: ["name": "a","count": 2]
    public func jsonValueDecoded() -> Any? {
        return try? JSONSerialization.jsonObject(with: self.utf8Data!, options: JSONSerialization.ReadingOptions())
    }
    
}


