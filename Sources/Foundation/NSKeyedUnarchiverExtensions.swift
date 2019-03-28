//
//  NSKeyedUnarchiverExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/10.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(Foundation)
import Foundation

public extension NSKeyedUnarchiver {
    
    /// YYSwift: Same as unarchiveObjectWithFile:, except it returns the exception by reference.
    ///
    /// - Parameter file: The path of archived object file.
    /// - Returns: The unarchived object
    /// - Throws: Unarchived error
    class func unarchiveObject(withFilePath file: String) throws -> Any {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file))
            var object: Any?
            do {
                #if os(macOS)
                if #available(OSX 10.11, *) {
                    object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
                } else {
                    // Fallback on earlier versions
                }
                #else
                object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
                #endif
            } catch let error {
                throw error
            }
            return object!
        } catch let error {
            throw error
        }
    }
    
    /// YYSwift: Same as unarchiveObjectWithData:, except it returns the exception by reference.
    ///
    /// - Parameter data: The data need unarchived.
    /// - Returns: The unarchived object
    /// - Throws: Unarchived error
    class func unarchiveObject(withFileData data: Data) throws -> Any {
        var object: Any?
        do {
            #if os(macOS)
                if #available(OSX 10.11, *) {
                    object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
                } else {
                    // Fallback on earlier versions
                }
            #else
                object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
            #endif
        }
        catch let error {
            throw error
        }
        return object!
    }
}
#endif
