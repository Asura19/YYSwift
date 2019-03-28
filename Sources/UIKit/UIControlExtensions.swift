//
//  UIControlExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/20.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Methods
public extension UIControl {
    
    /// YYSwift: Removes all targets and actions for a particular event (or events)
    /// from an internal dispatch table.
    func removeAllTargets() {
        for object in self.allTargets {
            self.removeTarget(object, action: nil, for: UIControl.Event.allEvents)
        }
        var targets = allTargetsBlock
        targets.removeAll()
        allTargetsBlock = targets
    }
    
    /// YYSwift: Adds a block for a particular event (or events) to an internal dispatch table.
    /// It will cause a strong reference to @a block.
    ///
    /// - Parameters:
    ///   - events: The block which is invoked then the action message is
    ///             sent  (cannot be nil). The block is retained.
    ///   - block: A bitmask specifying the control events for which the
    ///            action message is sent.
    func addBlock(forControlEvents events: UIControl.Event, block: @escaping (Any) -> Void) {
        let target = YYUIControlBlockTarget(block: block, events: events)
        self.addTarget(target, action: #selector(target.invoke(with:)), for: events)
        var targets = allTargetsBlock
        targets.append(target)
        allTargetsBlock = targets
    }
    
    /// YYSwift: Adds or replaces a block for a particular event (or events) to an internal
    /// dispatch table. It will cause a strong reference to @a block.
    ///
    /// - Parameters:
    ///   - events: A bitmask specifying the control events for which the
    ///             action message is sent.
    ///   - block: The block which is invoked then the action message is
    ///            sent (cannot be nil). The block is retained.
    func setBlock(forControlEvents events: UIControl.Event, block: @escaping (Any) -> Void) {
        self.removeAllBlocks(forControlEvents: UIControl.Event.allEvents)
        self.addBlock(forControlEvents: events, block: block)
    }
    
    /// YYSwift: Removes all blocks for a particular event (or events) from an internal
    /// dispatch table.
    ///
    /// - Parameter events: A bitmask specifying the control events for which the
    ///                     action message is sent.
    func removeAllBlocks(forControlEvents events: UIControl.Event) {
        var targets = allTargetsBlock
        for target in targets {
            var targetEventsRawValue = target.events.rawValue
            for event in events.elements() {
                if target.events.elements().contains(event) {
                    self.removeTarget(target, action: #selector(target.invoke(with:)), for: event)
                    targetEventsRawValue -= event.rawValue
                }
                
            }
            if targetEventsRawValue == 0 {
                if let index = targets.firstIndex(where: { $0 == target }) {
                    targets.remove(at: index)
                }
            }
        }
        allTargetsBlock = targets
    }
    
    /// YYSwift: Adds or replaces a target and action for a particular event (or events)
    /// to an internal dispatch table.
    ///
    /// - Parameters:
    ///   - target: The target object—that is, the object to which the
    ///             action message is sent. If this is nil, the responder
    ///             chain is searched for an object willing to respond to the
    ///             action message.
    ///   - action: A selector identifying an action message.
    ///   - events: A bitmask specifying the control events for which the
    ///             action message is sent.
    func setTarget(_ target: Any, action: Selector, forControlEvents events: UIControl.Event) {
        let targets = self.allTargets
        for currentTarget in targets {
            guard let actions = self.actions(forTarget: currentTarget, forControlEvent: events) else {
                return
            }
            for currentAction in actions {
                self.removeTarget(currentTarget, action: NSSelectorFromString(currentAction), for: events)
            }
        }
        self.addTarget(target, action: action, for: events)
    }
    
    private var allTargetsBlock: [YYUIControlBlockTarget] {
        get {
            guard let targets = objc_getAssociatedObject(self, Key.Associated) as? [YYUIControlBlockTarget] else {
                let newTargets: [YYUIControlBlockTarget] = []
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

private class YYUIControlBlockTarget: NSObject {
    
    var block: (Any) -> Void
    var events: UIControl.Event
    
    public init(block: @escaping (Any) -> Void, events: UIControl.Event) {
        self.block = block
        self.events = events
    }
    
    @objc func invoke(with sender: Any) {
        self.block(sender)
    }
    
}
#endif
