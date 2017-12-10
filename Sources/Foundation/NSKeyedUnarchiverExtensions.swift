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
                object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
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
            object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
        }
        catch let error {
            throw error
        }
        return object!
    }
}
