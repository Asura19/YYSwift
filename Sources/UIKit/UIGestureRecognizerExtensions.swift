//
//  UIGestureRecognizerExtensions.swift
//  YYSwift-iOS
//
//  Created by Phoenix on 2018/1/4.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Initializers
public extension UIGestureRecognizer {
    
    /// YYSwift: Initializes an allocated gesture-recognizer object with a action block.
    ///
    /// - Parameter actionBlock: An action block that to handle the gesture
    ///                          recognized by the receiver. nil is invalid.
    ///                          It is retained by the gesture.
    convenience init(actionBlock: @escaping (Any) -> Void) {
        self.init()
        self.addActionBlock(actionBlock)
    }
}

// MARK: - Methods
public extension UIGestureRecognizer {
    
    /// YYSwift: Adds an action block to a gesture-recognizer object. It is retained by the
    /// gesture.
    ///
    /// - Parameter block: A block invoked by the action message.
    func addActionBlock(_ block: @escaping (Any) -> Void) {
        let target = YYUIGestureRecognizerBlockTarget(block: block)
        self.addTarget(target, action: #selector(target.invoke(with:)))
        var targets = allTargetsBlock
        targets.append(target)
        allTargetsBlock = targets
    }
    
    /// YYSwift: Remove all action blocks.
    func removeAllActionBlocks() {
        var targets = allTargetsBlock
        for target in targets {
            self.removeTarget(target, action: #selector(target.invoke(with:)))
        }
        targets.removeAll()
        allTargetsBlock = targets
    }
    
    private var allTargetsBlock: [YYUIGestureRecognizerBlockTarget] {
        get {
            guard let targets = objc_getAssociatedObject(self, Key.Associated) as? [YYUIGestureRecognizerBlockTarget] else {
                let newTargets: [YYUIGestureRecognizerBlockTarget] = []
                objc_setAssociatedObject(self, Key.Associated, newTargets, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return newTargets
            }
            return targets
        }
        set {
            objc_setAssociatedObject(self, Key.Associated, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// YYSwift: Remove Gesture Recognizer from its view.
    func removeFromView() {
        self.view?.removeGestureRecognizer(self)
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
#endif
