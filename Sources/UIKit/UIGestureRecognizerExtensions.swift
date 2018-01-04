//
//  UIGestureRecognizerExtensions.swift
//  YYSwift-iOS
//
//  Created by Phoenix on 2018/1/4.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

public extension UIGestureRecognizer {
    
    public convenience init(actionBlock: @escaping (Any) -> Void) {
        self.init()
        self.addActionBlock(actionBlock)
    }
}

public extension UIGestureRecognizer {
    
    public func addActionBlock(_ block: @escaping (Any) -> Void) {
        let target = YYUIGestureRecognizerBlockTarget(block: block)
        self.addTarget(target, action: #selector(target.invoke(with:)))
        var targets = allTargetsBlock
        targets.append(target)
        allTargetsBlock = targets
    }
    
    public func removeAllActionBlocks() {
        var targets = allTargetsBlock
        for target in targets {
            self.removeTarget(target, action: #selector(target.invoke(with:)))
        }
        targets.removeAll()
        allTargetsBlock = targets
    }
    
    private var allTargetsBlock: Array<YYUIGestureRecognizerBlockTarget> {
        get {
            guard let targets = objc_getAssociatedObject(self, Key.Associated) as? [YYUIGestureRecognizerBlockTarget] else {
                let newTargets = [YYUIGestureRecognizerBlockTarget]()
                objc_setAssociatedObject(self, Key.Associated, newTargets, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return newTargets
            }
            return targets
        }
        set {
            objc_setAssociatedObject(self, Key.Associated, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

private struct Key {
    static let Associated = "\(#file)+\(#line)"
}

private class YYUIGestureRecognizerBlockTarget: NSObject {
    
    var block: (Any) -> Void
    init(block: @escaping (Any) -> Void) {
        self.block = block
    }
    
    @objc func invoke(with sender: Any) {
        self.block(sender)
    }
}
