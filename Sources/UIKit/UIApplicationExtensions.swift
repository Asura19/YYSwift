//
//  UIApplicationExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/10.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    public var documentsURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }
    
    public var documentsPath: String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }
    
    public var cachesURL: URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last
    }
    
    public var cachesPath: String? {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    
    public var libraryURL: URL? {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last
    }
    
    public var libraryPath: String? {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
    }
    
    public var isPirated: Bool {
        if UIDevice.current.isSimulator {
            return true
        }
        if getgid() < 10 {
            return true
        }
        
        if let dict = Bundle.main.infoDictionary, dict["SignerIdentity"] != nil {
            return true
        }
        
        if !self.fileExistInMainBundle("_CodeSignature") {
            return true
        }
        
        if !self.fileExistInMainBundle("SC_Info") {
            return true
        }
        
        return false
    }
    
    public var appBundleName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    public var appBundleID: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String
    }
    
    public var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    public var appBuildVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    
    private func fileExistInMainBundle(_ name: String) -> Bool {
        let bundlePath = Bundle.main.bundlePath
        let path = bundlePath + "/" + name
        return FileManager.default.fileExists(atPath: path)
    }
}
