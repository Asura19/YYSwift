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

public extension String {
    
    #if os(macOS) || os(iOS)
    public var md2String: String? {
        return self.utf8Data?.md2String
    }
    
    public var md4String: String? {
        return self.utf8Data?.md4String
    }
    
    public var md5String: String? {
        return self.utf8Data?.md5String
    }
    
    public var sha1String: String? {
        return self.utf8Data?.sha1String
    }
    
    public var sha224String: String? {
        return self.utf8Data?.sha224String
    }
    
    public var sha256String: String? {
        return self.utf8Data?.sha256String
    }
    
    public var sha384String: String? {
        return self.utf8Data?.sha384String
    }
    
    public var sha512String: String? {
        return self.utf8Data?.sha384String
    }
    
    public func hmacMD5StringWithKey(_ key: String) -> String? {
        return self.utf8Data?.hmacMD5StringWithKey(key)
    }
    
    public func hmacSHA1StringWithKey(_ key: String) -> String? {
        return self.utf8Data?.hmacSHA1StringWithKey(key)
    }
    
    public func hmacSHA224StringWithKey(_ key: String) -> String? {
        return self.utf8Data?.hmacSHA224StringWithKey(key)
    }
    
    public func hmacSHA256StringWithKey(_ key: String) -> String? {
        return self.utf8Data?.hmacSHA256StringWithKey(key)
    }

    public func hmacSHA384StringWithKey(_ key: String) -> String? {
        return self.utf8Data?.hmacSHA384StringWithKey(key)
    }
    
    public func hmacSHA512StringWithKey(_ key: String) -> String? {
        return self.utf8Data?.hmacSHA512StringWithKey(key)
    }
    #endif
    
    public var utf8Data: Data? {
        return self.data(using: .utf8)
    }
    
    public var base64Decoded: String? {
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }
    
    public var base64Encoded: String? {
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
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
    

    
    public func contain(characterSet: CharacterSet) -> Bool {
        return rangeOfCharacter(from: characterSet) != nil
    }
    
    public var firstCharacterAsString: String? {
        guard let first = first else {
            return nil
        }
        return String(first)
    }
    
    public var lastCharacterAsString: String? {
        guard let last = last else {
            return nil
        }
        return String(last)
    }
    
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    public var isAlphabetic: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasLetters && !hasNumbers
    }
    
    public var isNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return  !hasLetters && hasNumbers
    }
    
    public var isAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    }
    
    public var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    public var isValidSchemedUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return url.scheme != nil
    }
    
    public var isValidHttpsUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return url.scheme == "https"
    }
    
    public var isValidHttpUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return url.scheme == "http"
    }
    
    public var isValidFileUrl: Bool {
        return URL(string: self)?.isFileURL ?? false
    }
    
    public var latinized: String {
        return folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
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
    
    public var date: Date? {
        let selfLowercased = trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    public var dateTime: Date? {
        let selfLowercased = trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    public var int: Int? {
        return Int(self)
    }
    
    public var url: URL? {
        return URL(string: self)
    }
    
    public var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
    public var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    public var withoutSpacesAndNewLines: String {
        return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
    
    

}

public extension String {
    
    public func matches(pattern: String) -> Bool {
        return range(of: pattern,
                     options: String.CompareOptions.regularExpression,
                     range: nil,
                     locale: nil) != nil
    }
    
    public func enumerate(regex: String, options: NSRegularExpression.Options, _ execute: (String, CountableRange<Int>, Bool) -> Void) {
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
    
    public func replace(regex: String, options: NSRegularExpression.Options, with replacement: String) -> String {
        if regex.count == 0 {
            return self
        }
        guard let pattern = try? NSRegularExpression.init(pattern: regex, options: options) else {
            return self
        }
        return pattern.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: replacement)
    }
    
    public func removeAll(_ target: String) -> String {
        return replacingOccurrences(of: target, with: "")
    }

    public func float(locale: Locale = .current) -> Float? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self) as? Float
    }
    
    public func double(locale: Locale = .current) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self) as? Double
    }
    
    public func cgFloat(locale: Locale = .current) -> CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self) as? CGFloat
    }
    
    public func lines() -> [String] {
        var result: [String] = []
        enumerateLines { line, _ in
            result.append(line)
        }
        return result
    }
    
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
    
    public func unicodeArray() -> [Int] {
        return unicodeScalars.map({ $0.hashValue })
    }
    
    public func words() -> [String] {
        // https://stackoverflow.com/questions/42822838
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = components(separatedBy: chararacterSet)
        return comps.filter { !$0.isEmpty }
    }
    
    public func wordCount() -> Int {
        // https://stackoverflow.com/questions/42822838
        return words().count
    }
    
    public subscript(_ i: Int) -> String? {
        guard i >= 0 && i < count else {
            return nil
        }
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    public subscript(_ range: CountableRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else {
            return nil
        }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else {
            return nil
        }
        return String(self[lowerIndex..<upperIndex])
    }
    
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
    public func copyToPasteboard() {
        #if os(iOS)
            UIPasteboard.general.string = self
        #elseif os(macOS)
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(self, forType: .string)
        #endif
    }
    #endif
    
    public mutating func camelize() {
        self = camelCased
    }
    
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
    
    public func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
    
    public func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return lowercased().components(separatedBy: string.lowercased()).count - 1
        }
        return components(separatedBy: string).count - 1
    }
    
    public func starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }
    
    public func ends(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }
    
    public mutating func latinize() {
        self = latinized
    }
    
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
    
    public mutating func slice(from i: Int, length: Int) {
        
        if let str = self.slicing(from: i, length: length) {
            self = String(str)
        }
    }
    
    
    public mutating func slice(from start: Int, to end: Int) {
        guard end >= start else {
            return
        }
        
        if let str = self[start..<end] {
            self = str
        }
    }
    
    public mutating func slice(from i: Int) {
        guard i < count else {
            return
        }
        
        if let str = self[i..<count] {
            self = str
        }
    }
    
    public mutating func slice(to i: Int) {
        guard i > 0 else {
            return
        }
        
        if let str = self[0..<i] {
            self = str
        }
    }

    
    public func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    public mutating func trim() {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public mutating func truncate(toLength length: Int, trailing: String? = "...") {
        guard length > 0 else {
            return
        }
        if count > length {
            self = self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
        }
    }
    
    public func truncated(toLength length: Int, trailing: String? = "...") -> String {
        guard 1..<count ~= length else {
            return self
        }
        return self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
    }
    
    
}


public extension String {
    
    public static func * (lhs: String, rhs: Int) -> String {
        guard rhs > 0 else {
            return ""
        }
        return String(repeating: lhs, count: rhs)
    }
    
    public static func * (lhs: Int, rhs: String) -> String {
        guard lhs > 0 else {
            return ""
        }
        return String(repeating: rhs, count: lhs)
    }
    
}

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

public extension String {
    public static func uuid() -> String {
        return UUID().uuidString
    }
}



public extension String {
    
    #if !os(tvOS) && !os(watchOS)
    public var bold: NSAttributedString {
        #if os(macOS)
            return NSMutableAttributedString(string: self, attributes: [.font: NSFont.boldSystemFont(ofSize: NSFont.systemFontSize)])
        #else
            return NSMutableAttributedString(string: self, attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
        #endif
    }
    #endif
    
    public var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
    }
    
    public var strikethrough: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)])
    }
    
    #if os(iOS)
    public var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    #endif
    
    #if os(macOS)
    public func colored(with color: NSColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
    
    #else
    public func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
    #endif
    
    #if os(iOS) || os(tvOS) || os(watchOS)
    public func size(forFont font: UIFont, size: CGSize, lineBreakMode: NSLineBreakMode) -> CGSize {
        var result: CGSize
        var attr: [NSAttributedStringKey: Any] = [:]
        attr[.font] = font
        if lineBreakMode != .byWordWrapping {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode
            attr[.paragraphStyle] = paragraphStyle
        }
        let rect = NSString(string: self).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attr, context: nil)
        result = rect.size
        return result
    }
    
    
  
    #endif
}


public extension String {

    public var nsString: NSString {
        return NSString(string: self)
    }

    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }

    public var pathExtension: String {
        return (self as NSString).pathExtension
    }

    public var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }

    public var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    public var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    
    public func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }

    public func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
    
    public func appending(nameScale scale: CGFloat) -> String {
        if fabs(scale - 1) <= CGFloat.ulpOfOne
            || self.count == 0
            || self.hasSuffix("/") {
            return self
        }
        return self.appendingFormat("@%@x", String(describing: scale))
    }
    
    public func appending(pathScal scale: CGFloat) -> String {
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
    
    public func jsonValueDecoded() -> Any? {
        return try? JSONSerialization.jsonObject(with: self.utf8Data!, options: JSONSerialization.ReadingOptions())
    }
    
}


