//
//  UIBarButtonItemExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/20.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit

// MARK: - Initializers
public extension UIBarButtonItem {
    
    /// YYSwift: Create a button item with image name, and add action
    ///
    /// - Parameters:
    ///   - iconName: image name
    ///   - highlightedIconName: highlighted image name
    ///   - target: the object whose action method is called
    ///   - action: A selector identifying the action method to be called
    public convenience init(iconName: String, highlightedIconName: String?, target: Any?, action: Selector) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: iconName), for: .normal)
        if let name = highlightedIconName {
            button.setImage(UIImage(named: name), for: .highlighted)
        }
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: button)
    }
    
}

// MARK: - Properties
public extension UIBarButtonItem {
    
    /// YYSwift: The block that invoked when the item is selected. The objects captured by block will retained by the ButtonItem.
    /// - note: This param is conflict with `target` and `action` property.
    /// Set this will set `target` and `action` property to some internal objects.
    public var actionBlock: ((Any) -> Void) {
        get {
            let target = objc_getAssociatedObject(self, Key.Associated) as! YYUIBarButtonItemBlockTarget
            return target.block
        }
        set {
            let target = YYUIBarButtonItemBlockTarget(block: newValue)
            objc_setAssociatedObject(self, Key.Associated, target, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.target = target
            self.action = #selector(target.invoke(with:))
        }
    }
}

private struct Key {
    static let Associated = "\(#file)+\(#line)"
}

private class YYUIBarButtonItemBlockTarget: NSObject {
    
    var block: (Any) -> Void
    init(block: @escaping (Any) -> Void) {
        self.block = block
    }
    
    @objc func invoke(with sender: Any) {
        self.block(sender)
    }
}
