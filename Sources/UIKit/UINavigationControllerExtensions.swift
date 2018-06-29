//
//  UINavigationControllerExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/8.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Methods
public extension UINavigationController {
    
    /// YYSwift: Pop ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - animated: Set this value to true to animate the transition (default is true).
    ///   - completion: optional completion handler (default is nil).
    public func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    /// YYSwift: Push ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - viewController: viewController to push.
    ///   - completion: optional completion handler (default is nil).
    public func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    /// YYSwift: Make navigation controller's navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    public func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tint]
    }
}
#endif
