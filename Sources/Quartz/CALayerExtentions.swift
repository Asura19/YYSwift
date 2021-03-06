//
//  CALayerExtentions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/10.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif

// MARK: - Properties
public extension CALayer {
    
    /// YYSwift: Take snapshot without transform, image's size equals to bounds.
    var snapshotImage: UIImage? {
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
    
    /// YYSwift: Take snapshot without transform, PDF's page size equals to bounds.
    var snapshotPDF: Data? {
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
    
    /// YYSwift: Shortcut for frame.origin.x.
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// YYSwift: Shortcut for frame.origin.y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    /// YYSwift: Shortcut for frame.size.width.
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// YYSwift: Shortcut for frame.size.height.
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    /// YYSwift: Shortcut for frame.origin.x.
    var left: CGFloat {
        get {
            return x
        }
        set {
            x = newValue
        }
    }
    
    /// YYSwift: Shortcut for frame.origin.x + frame.size.width
    var right: CGFloat {
        get {
            return x + width
        }
        set {
            x = newValue - width
        }
    }
    
    /// YYSwift: Shortcut for frame.origin.y
    var top: CGFloat {
        get {
            return y
        }
        set {
            y = newValue
        }
    }
    
    /// YYSwift: Shortcut for frame.origin.y + frame.size.height
    var bottom: CGFloat {
        get {
            return y + height
        }
        set {
            x = newValue - height
        }
    }
    
    /// YYSwift: Shortcut for center.
    var center: CGPoint {
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
    
    /// YYSwift: Shortcut for center.x
    var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center = CGPoint.init(x: newValue, y: center.y)
        }
    }
    
    /// YYSwift: Shortcut for center.y
    var centerY: CGFloat {
        get {
            return center.y
        }
        set  {
            center = CGPoint.init(x: center.x, y: newValue)
        }
    }
    
    /// YYSwift: Shortcut for frame.origin.
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }
    
    /// YYSwift: Shortcut for frame.size.
    var frameSize: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
    /// YYSwift: key path "tranform.rotation"
    var transformRotation: CGFloat {
        get {
            return value(forKeyPath: "transform.rotation") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.rotation")
        }
    }
    
    /// YYSwift: key path "tranform.rotation.x"
    var transformRotationX: CGFloat {
        get {
            return value(forKeyPath: "transform.rotation.x") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.rotation.x")
        }
    }
    
    /// YYSwift: key path "tranform.rotation.y"
    var transformRotationY: CGFloat {
        get {
            return value(forKeyPath: "transform.rotation.y") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.rotation.y")
        }
    }
    
    /// YYSwift: key path "tranform.rotation.z"
    var transformRotationZ: CGFloat {
        get {
            return value(forKeyPath: "transform.rotation.z") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.rotation.z")
        }
    }
    
    /// YYSwift: key path "tranform.scale.x"
    var transformScaleX: CGFloat {
        get {
            return value(forKeyPath: "transform.scale.x") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.scale.x")
        }
    }
    
    /// YYSwift: key path "tranform.scale.y"
    var transformScaleY: CGFloat {
        get {
            return value(forKeyPath: "transform.scale.y") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.scale.y")
        }
    }
    
    /// YYSwift: key path "tranform.scale.z"
    var transformScaleZ: CGFloat {
        get {
            return value(forKeyPath: "transform.scale.z") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.scale.z")
        }
    }
    
    /// YYSwift: key path "tranform.scale"
    var transformScale: CGFloat {
        get {
            return value(forKeyPath: "transform.scale") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.scale")
        }
    }
    
    /// YYSwift: key path "tranform.translation"
    var transformTranslation: CGFloat {
        get {
            return value(forKeyPath: "transform.translation") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.translation")
        }
    }
    
    /// YYSwift: key path "tranform.translation.x"
    var transformTranslationX: CGFloat {
        get {
            return value(forKeyPath: "transform.translation.x") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.translation.x")
        }
    }
    
    /// YYSwift: key path "tranform.translation.y"
    var transformTranslationY: CGFloat {
        get {
            return value(forKeyPath: "transform.translation.y") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.translation.y")
        }
    }
    
    /// YYSwift: key path "tranform.translation.z"
    var transformTranslationZ: CGFloat {
        get {
            return value(forKeyPath: "transform.translation.z") as! CGFloat
        }
        set {
            setValue(newValue, forKeyPath: "transform.translation.z")
        }
    }
    
    /// YYSwift: Shortcut for transform.m34, -1/1000 is a good value.
    /// It should be set before other transform shortcut.
    var transformDepth: CGFloat {
        get {
            return transform.m34
        }
        set {
            var d = self.transform
            d.m34 = newValue
            self.transform = d
        }
    }
    
    /// YYSwift: Wrapper for `contentsGravity` property.
    var contentMode: UIView.ContentMode {
        get {
            return YYCAGravityToUIViewContentMode(gravity: contentsGravity)
        }
        set {
            contentsGravity = YYUIViewContentModeToCAGravity(contentMode: newValue)
        }
    }
    
}

// MARK: - Method
public extension CALayer {
    
    /// YYSwift: Add shadow and radius to the layer.
    ///
    /// - Parameters:
    ///   - color: shadow color
    ///   - radius: corner radius
    ///   - offset: shadow offset
    ///   - opacity: shadow opacity
    func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        shadowColor = color.cgColor
        shadowOffset = offset
        shadowRadius = radius
        shadowOpacity = opacity
        masksToBounds = true
    }
    
    func removeAllSublayers() {
        self.sublayers?.removeAll()
    }
    
    /// YYSwift: Add a fade animation to layer's contents when the contents is changed.
    ///
    /// - Parameters:
    ///   - duration: animation duration
    ///   - curve: animation curve
    func addFadeAnimationWithDuration(_ duration: TimeInterval, curve: UIView.AnimationCurve) {
        if duration <= 0 {
            return
        }
        var mediaFunctionName: CAMediaTimingFunctionName
        switch curve {
        case .easeInOut:
            mediaFunctionName = .easeInEaseOut
        case .easeIn:
            mediaFunctionName = .easeIn
        case .easeOut:
            mediaFunctionName = .easeOut
        case .linear:
            mediaFunctionName = .linear
        @unknown default:
            mediaFunctionName = .linear
        }
        
        let transition = CATransition()
        transition.duration = duration as CFTimeInterval
        transition.timingFunction = CAMediaTimingFunction(name: mediaFunctionName)
        add(transition, forKey: "yyswift.fade")
    }
    
    /// YYSwift: Cancel fade animation which is added with "-addFadeAnimationWithDuration:curve:".
    func removePreviousFadeAnimation() {
        removeAnimation(forKey: "yyswift.fade")
    }
}

