//
//  CALayerExtentions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/10.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

public extension CALayer {
    
    public var snapshotImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        render(in: context)
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
        render(in: context)
        context.endPDFPage()
        return data as Data
    }
    
    public func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        shadowColor = color.cgColor
        shadowOffset = offset
        shadowRadius = radius
        shadowOpacity = opacity
        masksToBounds = true
    }
    
    public func removeAllSublayers() {
        self.sublayers?.removeAll()
    }
    
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
    
    public var center: CGPoint {
        get {
            return CGPoint(x: self.frame.origin.x + self.frame.size.width * 0.5, y: self.frame.origin.y + self.frame.size.height * 0.5)
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue.x - frame.size.width * 0.5
            frame.origin.y = newValue.y - frame.size.height * 0.5
            self.frame = frame
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
    
    public var frameSize: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
    public var transformRotation: CGFloat {
        get {
            return value(forKeyPath: "transform.rotation") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.rotation")
        }
    }
    
    public var transformRotationX: CGFloat {
        get {
            return value(forKeyPath: "transform.rotation.x") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.rotation.x")
        }
    }
    
    public var transformRotationY: CGFloat {
        get {
            return value(forKeyPath: "transform.rotation.y") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.rotation.y")
        }
    }
    
    public var transformRotationZ: CGFloat {
        get {
            return value(forKeyPath: "transform.rotation.z") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.rotation.z")
        }
    }
    
    public var transformScaleX: CGFloat {
        get {
            return value(forKeyPath: "transform.scale.x") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.scale.x")
        }
    }
    
    public var transformScaleY: CGFloat {
        get {
            return value(forKeyPath: "transform.scale.y") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.scale.y")
        }
    }
    
    public var transformScaleZ: CGFloat {
        get {
            return value(forKeyPath: "transform.scale.z") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.scale.z")
        }
    }
    
    public var transformScale: CGFloat {
        get {
            return value(forKeyPath: "transform.scale") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.scale")
        }
    }
    
    public var transformTranslationX: CGFloat {
        get {
            return value(forKeyPath: "transform.translation.x") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.translation.x")
        }
    }
    
    public var transformTranslationY: CGFloat {
        get {
            return value(forKeyPath: "transform.translation.y") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.translation.y")
        }
    }
    
    public var transformTranslationZ: CGFloat {
        get {
            return value(forKeyPath: "transform.translation.z") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.translation.z")
        }
    }
    
    public var transformDepth: CGFloat {
        get {
            return transform.m34
        }
        set {
            var d = self.transform
            d.m34 = newValue
            self.transform = d
        }
    }
    
    public var contentMode: UIViewContentMode {
        get {
            return YYCAGravityToUIViewContentMode(gravity: contentsGravity)
        }
        set {
            contentsGravity = YYUIViewContentModeToCAGravity(contentMode: newValue)
        }
    }
    
    public func addFadeAnimationWithDuration(_ duration: TimeInterval, curve: UIViewAnimationCurve) {
        if duration <= 0 {
            return
        }
        var mediaFunction = ""
        switch curve {
        case .easeInOut:
            mediaFunction = kCAMediaTimingFunctionEaseInEaseOut
        case .easeIn:
            mediaFunction = kCAMediaTimingFunctionEaseIn
        case .easeOut:
            mediaFunction = kCAMediaTimingFunctionEaseOut
        case .linear:
            mediaFunction = kCAMediaTimingFunctionLinear
            
        let transition = CATransition()
        transition.duration = duration as CFTimeInterval
        transition.timingFunction = CAMediaTimingFunction(name: mediaFunction)
        add(transition, forKey: "yyswift.fade")
        }
    }
        
    public func removePreviousFadeAnimation() {
        removeAnimation(forKey: "yyswift.fade")
    }
}
