//
//  UIWindowExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/6/29.
//  Copyright © 2018 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if os(iOS)
public extension UIWindow {
    
    /// YYSwift: Switch current root view controller with a new view controller.
    ///
    /// - Parameters:
    ///   - viewController: new view controller.
    ///   - animated: set to true to animate view controller change (default is true).
    ///   - duration: animation duration in seconds (default is 0.5).
    ///   - options: animataion options (default is .transitionFlipFromRight).
    ///   - completion: optional completion handler called after view controller is changed.
    public func switchRootViewController(
        to viewController: UIViewController,
        animated: Bool = true,
        duration: TimeInterval = 0.5,
        options: UIView.AnimationOptions = .transitionFlipFromRight,
        _ completion: (() -> Void)? = nil) {
        
        guard animated else {
            rootViewController = viewController
            completion?()
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
    
}
#endif
#endif
