//
//  File.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/5.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

public extension UIView {
    
    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    public var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    public var left: CGFloat {
        get {
            return x
        }
        set {
            x = newValue
        }
    }
    
    public var right: CGFloat {
        get {
            return x + width
        }
        set {
            x = newValue - width
        }
    }
    
    public var top: CGFloat {
        get {
            return y
        }
        set {
            y = newValue
        }
    }
    
    public var bottom: CGFloat {
        get {
            return y + height
        }
        set {
            x = newValue - height
        }
    }
    
    public var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center = CGPoint.init(x: newValue, y: center.y)
        }
    }
    
    public var centerY: CGFloat {
        get {
            return center.y
        }
        set  {
            center = CGPoint.init(x: center.x, y: newValue)
        }
    }
    
    public var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }
    
    public var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
}


public extension UIView {
    
    public var snapshotImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public func snapshot(afterScreenUpdates afterUpdates: Bool) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        drawHierarchy(in: bounds, afterScreenUpdates: afterUpdates)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public var snapshotPDF: Data? {
        var pBounds = bounds
        let data = NSMutableData()
        guard let consumer = CGDataConsumer(data: data as CFMutableData) else {
            return nil
        }
        guard let context = CGContext.init(consumer: consumer, mediaBox: &pBounds, nil) else {
            return nil
        }
        context.beginPDFPage(nil)
        context.translateBy(x: 0, y: pBounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        layer.render(in: context)
        context.endPDFPage()
        return data as Data
    }
    
    public func setLayer(shadow color: UIColor, offset: CGSize, radius: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    public func removeAllSubviews() {
        subviews.forEach({$0.removeFromSuperview()})
    }
    
    public var viewController: UIViewController? {
        guard let next = next else {
            return nil
        }
        
        if next is UIViewController {
            return (next as! UIViewController)
        }
        else {
            var view = self.superview
            while view != nil {
                guard let next = view!.next else {
                    return nil
                }
                if next is UIViewController {
                    return (next as! UIViewController)
                }
                view = view!.superview
            }
        }
        return nil
    }
    
    public var visibleAlpha: CGFloat {
        if self is UIWindow {
            if isHidden {
                return 0
            }
            return self.alpha
        }
        if window == nil { return 0 }
        var alpha: CGFloat = 1
        var view: UIView? = self
        while view != nil {
            if view!.isHidden {
                alpha = 0
                break
            }
            alpha *= view!.alpha
            view = view!.superview
        }
        return alpha
    }
    
    public func convert(point: CGPoint, toViewOrWindow view: UIView) -> CGPoint {
        var point = point
        let from = self is UIWindow ? self as? UIWindow : self.window
        let to = view is UIWindow ? view as? UIWindow : view.window
        if (from == nil || to == nil) || (from == to) {
            return self.convert(point, to: view)
        }
        point = self.convert(point, to: from!)
        point = to!.convert(point, from: from!)
        point = view.convert(point, from: to!)
        return point
    }
    
    public func convert(point: CGPoint, fromViewOrWindow view: UIView) -> CGPoint {
        var point = point
        let from = view is UIWindow ? view as? UIWindow : view.window
        let to = self is UIWindow ? self as? UIWindow : self.window
        if (from == nil || to == nil) || (from == to) {
            return self.convert(point, from: view)
        }
        point = from!.convert(point, from: view)
        point = to!.convert(point, from: from!)
        point = self.convert(point, from: view)
        return point
    }
    
    public func convert(rect: CGRect, toViewOrWindow view: UIView) -> CGRect {
        var rect = rect
        let from = self is UIWindow ? self as? UIWindow : self.window
        let to = view is UIWindow ? view as? UIWindow : view.window
        if (from == nil || to == nil) || (from == to) {
            return self.convert(rect, to: view)
        }
        rect = self.convert(rect, to: from!)
        rect = to!.convert(rect, from: from!)
        rect = view.convert(rect, from: to!)
        return rect
    }
    
    public func convert(rect: CGRect, fromViewOrWindow view: UIView) -> CGRect {
        var rect = rect
        let from = view is UIWindow ? view as? UIWindow : view.window
        let to = self is UIWindow ? self as? UIWindow : self.window
        if (from == nil || to == nil) || (from == to) {
            return self.convert(rect, from: view)
        }
        rect = from!.convert(rect, from: view)
        rect = to!.convert(rect, from: from!)
        rect = self.convert(rect, from: view)
        return rect
    }
}
