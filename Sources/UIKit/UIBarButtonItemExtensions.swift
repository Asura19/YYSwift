//
//  UIBarButtonItemExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/20.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit

public extension UIBarButtonItem {
    
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
    
    public var actionBlock: ((Any) -> Void) {
        get {
            let target = objc_getAssociatedObject(self, Key.Associated) as! YYUIBarButtonItemBlockTarget
            return target.block
        }
        set {
            let target = YYUIBarButtonItemBlockTarget(blcok: newValue)
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
    init(blcok: @escaping (Any) -> Void) {
        self.block = blcok
    }
    
    @objc func invoke(with sender: Any) {
        self.block(sender)
    }
}
