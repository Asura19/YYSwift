//
//  UIViewControllerExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/8.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public var isVisible: Bool {
        return self.isViewLoaded && view.window != nil
    }
}

public extension UIViewController {
    
    public func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    public func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }

    public func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
}
