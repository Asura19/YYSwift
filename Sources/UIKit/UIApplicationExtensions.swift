//
//  UIApplicationExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/10.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    /// YYSwift: "Documents" URL in this app's sandbox.
    public var documentsURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }
    
    /// YYSwift: "Documents" path in this app's sandbox.
    public var documentsPath: String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }
    
    /// YYSwift: "Caches" URL in this app's sandbox.
    public var cachesURL: URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last
    }
    
    /// YYSwift: "Caches" path in this app's sandbox.
    public var cachesPath: String? {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    
    /// YYSwift: "Library" URL in this app's sandbox.
    public var libraryURL: URL? {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last
    }
    
    /// YYSwift: "Library" path in this app's sandbox.
    public var libraryPath: String? {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
    }
    
    /// YYSwift: Whether this app is pirated (not install from appstore).
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
    
    /// YYSwift: Application's Bundle Name (show in SpringBoard).
    public var appBundleName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    /// YYSwift: Application's Bundle ID.  e.g. "com.phoenix.testApp"
    public var appBundleID: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String
    }
    
    /// YYSwift: Application's Version.  e.g. "1.2.0"
    public var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    /// YYSwift: Application's Build number. e.g. "123"
    public var appBuildVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    
    private func fileExistInMainBundle(_ name: String) -> Bool {
        let bundlePath = Bundle.main.bundlePath
        let path = bundlePath + "/" + name
        return FileManager.default.fileExists(atPath: path)
    }
}
