//
//  UIControlExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/20.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit

public extension UIControl {
    
    public func removeAllTargets() {
        for object in self.allTargets {
            self.removeTarget(object, action: nil, for: UIControlEvents.allEvents)
        }
        var targets = allTargetsBlock
        targets.removeAll()
        allTargetsBlock = targets
    }
    
    public func addBlock(forControlEvents events: UIControlEvents, block: @escaping (Any) -> Void) {
        let target = YYUIControlBlockTarget(block: block, events: events)
        self.addTarget(target, action: #selector(target.invoke(with:)), for: events)
        var targets = allTargetsBlock
        targets.append(target)
        allTargetsBlock = targets
    }
    
    public func setBlock(forControlEvents events: UIControlEvents, block: @escaping (Any) -> Void) {
        self.removeAllBlocks(forControlEvents: .allEvents)
        self.addBlock(forControlEvents: events, block: block)
    }
    
    public func removeAllBlocks(forControlEvents events: UIControlEvents) {
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
                if let index = targets.index(where: { $0 == target }) {
                    targets.remove(at: index)
                }
            }
        }
        allTargetsBlock = targets
    }
    
    public func setTarget(_ target: Any, action: Selector, forControlEvents controlEvents: UIControlEvents) {
        let targets = self.allTargets
        for currentTarget in targets {
            guard let actions = self.actions(forTarget: currentTarget, forControlEvent: controlEvents) else { return }
            for currentAction in actions {
                self.removeTarget(currentTarget, action: NSSelectorFromString(currentAction), for: controlEvents)
            }
        }
        self.addTarget(target, action: action, for: controlEvents)
    }
    
    private var allTargetsBlock: Array<YYUIControlBlockTarget> {
        get {
            guard let targets = objc_getAssociatedObject(self, Key.Associated) as? [YYUIControlBlockTarget] else {
                let newTargets = [YYUIControlBlockTarget]()
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
    var events: UIControlEvents
    
    public init(block: @escaping (Any) -> Void, events: UIControlEvents) {
        self.block = block
        self.events = events
    }
    
    @objc public func invoke(with sender: Any) {
        self.block(sender)
    }
    
}

