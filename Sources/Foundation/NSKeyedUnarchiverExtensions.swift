//
//  NSKeyedUnarchiverExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/10.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension NSKeyedUnarchiver {
    
    public class func unarchiveObject(withFilePath file: String) throws -> Any {
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
    
    public class func unarchiveObject(withFileData data: Data) throws -> Any {
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
