//
//  NotificationCenterExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/9.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(Foundation)
import Foundation

// MARK: - Methods
public extension NotificationCenter {
    
    /// YYSwift: Posts a given notification to the receiver on main thread.
    /// If current thread is main thread, the notification is posted synchronously;
    /// otherwise, is posted asynchronously.
    ///
    /// - Parameter notification: The notification to post.
    func postNotificationOnMainThread(notification: Notification) {
        if Int(pthread_main_np()).bool {
            return self.post(notification)
        }
        DispatchQueue.main.async {
            self.post(notification)
        }
    }
    
    /// YYSwift: Creates a notification with a given name and sender and posts it to the
    /// receiver on main thread. If current thread is main thread, the notification
    /// is posted synchronously; otherwise, is posted asynchronously.
    ///
    /// - Parameters:
    ///   - name: The name of the notification.
    ///   - object: The object posting the notification.
    func postNotificationOnMainThread(withName name: String, object: Any?) {
        if Int(pthread_main_np()).bool {
            return self.post(name: NSNotification.Name(rawValue: name), object: object)
        }
        DispatchQueue.main.async {
            self.post(name: NSNotification.Name(rawValue: name), object: object)
        }
    }
    
    /// YYSwift: Creates a notification with a given name and sender and posts it to the
    /// receiver on main thread. If current thread is main thread, the notification
    /// is posted synchronously; otherwise, is posted asynchronously.
    ///
    /// - Parameters:
    ///   - name: The name of the notification.
    ///   - object: The object posting the notification.
    ///   - userInfo: Information about the the notification. May be nil.
    func postNotificationOnMainThread(withName name: String, object: Any?, userInfo: [String: Any]) {
        if Int(pthread_main_np()).bool {
            return self.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo)
        }
        DispatchQueue.main.async {
            self.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo)
        }
    }
}
#endif
