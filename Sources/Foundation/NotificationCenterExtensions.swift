//
//  NotificationCenterExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/9.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public extension NotificationCenter {
    
    public func postNotificationOnMainThread(notification: Notification) {
        if Int(pthread_main_np()).bool {
            return self.post(notification)
        }
        DispatchQueue.main.async {
            self.post(notification)
        }
    }
    
    public func postNotificationOnMainThread(withName name: String, object: Any?) {
        if Int(pthread_main_np()).bool {
            return self.post(name: NSNotification.Name(rawValue: name), object: object)
        }
        DispatchQueue.main.async {
            self.post(name: NSNotification.Name(rawValue: name), object: object)
        }
    }
    
    public func postNotificationOnMainThread(withName name: String, object: Any?, userInfo: [String: Any]) {
        if Int(pthread_main_np()).bool {
            return self.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo)
        }
        DispatchQueue.main.async {
            self.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo)
        }
    }
}
