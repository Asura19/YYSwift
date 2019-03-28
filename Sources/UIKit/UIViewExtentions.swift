//
//  File.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/5.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - enums

/// YYSwift: Shake directions of a view.
///
/// - horizontal: Shake left and right.
/// - vertical: Shake up and down.
public enum ShakeDirection {
    case horizontal
    case vertical
}

/// YYSwift: Angle units.
///
/// - degrees: degrees.
/// - radians: radians.
public enum AngleUnit {
    case degrees
    case radians
}

/// YYSwift: Shake animations types.
///
/// - linear: linear animation.
/// - easeIn: easeIn animation
/// - easeOut: easeOut animation.
/// - easeInOut: easeInOut animation.
public enum ShakeAnimationType {
    case linear
    case easeIn
    case easeOut
    case easeInOut
}

// MARK: - Properties
public extension UIView {
    
    /// Shortcut for frame.origin.x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// Shortcut for frame.origin.y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    /// Shortcut for frame.size.width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// Shortcut for frame.size.height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    /// Shortcut for frame.origin.x
    var left: CGFloat {
        get {
            return x
        }
        set {
            x = newValue
        }
    }
    
    /// Shortcut for frame.origin.x + frame.size.width
    var right: CGFloat {
        get {
            return x + width
        }
        set {
            x = newValue - width
        }
    }
    
    /// Shortcut for frame.origin.y
    var top: CGFloat {
        get {
            return y
        }
        set {
            y = newValue
        }
    }
    
    /// Shortcut for frame.origin.y + frame.size.height
    var bottom: CGFloat {
        get {
            return y + height
        }
        set {
            x = newValue - height
        }
    }
    
    /// Shortcut for center.x
    var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center = CGPoint.init(x: newValue, y: center.y)
        }
    }
    
    /// Shortcut for center.y
    var centerY: CGFloat {
        get {
            return center.y
        }
        set  {
            center = CGPoint.init(x: center.x, y: newValue)
        }
    }
    
    /// Shortcut for frame.origin
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }
    
    /// Shortcut for frame.size
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
    /// YYSwift: Border color of view; also inspectable from Storyboard.
    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    /// YYSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// YYSwift: Corner radius of view; also inspectable from Storyboard.
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    /// YYSwift: Shadow color of view; also inspectable from Storyboard.
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// YYSwift: Shadow offset of view; also inspectable from Storyboard.
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// YYSwift: Shadow opacity of view; also inspectable from Storyboard.
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /// YYSwift: Shadow radius of view; also inspectable from Storyboard.
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// YYSwift: Check if view is in RTL format.
    var isRightToLeft: Bool {
        if #available(iOS 10.0, *, tvOS 10.0, *) {
            return effectiveUserInterfaceLayoutDirection == .rightToLeft
        }
        else {
            return false
        }
    }
    
    /// YYSwift: Create a snapshot image of the complete view hierarchy.
    var snapshotImage: UIImage? {
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
    
    /// Create a snapshot PDF of the complete view hierarchy.
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
        layer.render(in: context)
        context.endPDFPage()
        return data as Data
    }
}


public extension UIView {
    
    /// YYSwift: Recursively find the first responder.
    func firstResponder() -> UIView? {
        var views = [UIView](arrayLiteral: self)
        var i = 0
        repeat {
            let view = views[i]
            if view.isFirstResponder {
                return view
            }
            views.append(contentsOf: view.subviews)
            i += 1
        } while i < views.count
        return nil
    }
    
    /// Create a snapshot image of the complete view hierarchy.
    /// It's faster than "snapshotImage", but may cause screen updates.
    ///
    /// - Parameter afterUpdates: A Boolean value that indicates whether the snapshot should be rendered after recent changes have been incorporated. Specify the value false if you want to render a snapshot in the view hierarchy’s current state, which might not include recent changes.
    /// - Returns: a snapshot image of view
    func snapshot(afterScreenUpdates afterUpdates: Bool) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        drawHierarchy(in: bounds, afterScreenUpdates: afterUpdates)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// YYSwift: Add shadow to view.
    ///
    /// - Parameters:
    ///   - color: shadow color (default is #137992).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0),
                          radius: CGFloat = 3,
                          offset: CGSize = .zero,
                          opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = true
    }
    
    /// Remove all subviews
    func removeAllSubviews() {
        subviews.forEach({$0.removeFromSuperview()})
    }
    
    /// YYSwift: Get view's parent view controller
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    /// Returns the visible alpha on screen, taking into account superview and window.
    var visibleAlpha: CGFloat {
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
    
    /// Converts a point from the receiver's coordinate system to that of the specified view or window.
    ///
    /// - Parameters:
    ///   - point: A point specified in the local coordinate system (bounds) of the receiver.
    ///   - view: The view or window into whose coordinate system point is to be converted.
    ///           If view is nil, this method instead converts to window base coordinates.
    /// - Returns: The point converted to the coordinate system of view.
    func convert(point: CGPoint, toViewOrWindow view: UIView) -> CGPoint {
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
    
    /// Converts a point from the coordinate system of a given view or window to that of the receiver.
    ///
    /// - Parameters:
    ///   - point: A point specified in the local coordinate system (bounds) of view.
    ///   - view: The view or window with point in its coordinate system.
    ///           If view is nil, this method instead converts from window base coordinates.
    /// - Returns: The point converted to the local coordinate system (bounds) of the receiver.
    func convert(point: CGPoint, fromViewOrWindow view: UIView) -> CGPoint {
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
    
    /// Converts a rectangle from the receiver's coordinate system to that of another view or window.
    ///
    /// - Parameters:
    ///   - rect: A rectangle specified in the local coordinate system (bounds) of the receiver.
    ///   - view: The view or window that is the target of the conversion operation.
    ///           If view is nil, this method instead converts to window base coordinates.
    /// - Returns: The converted rectangle.
    func convert(rect: CGRect, toViewOrWindow view: UIView) -> CGRect {
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
    
    /// Converts a rectangle from the coordinate system of another view or window to that of the receiver.
    ///
    /// - Parameters:
    ///   - rect: A rectangle specified in the local coordinate system (bounds) of view.
    ///   - view: The view or window with rect in its coordinate system.
    ///           If view is nil, this method instead converts from window base coordinates.
    /// - Returns: The converted rectangle.
    func convert(rect: CGRect, fromViewOrWindow view: UIView) -> CGRect {
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
    
    /// YYSwift: Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    /// YYSwift: Load view from nib.
    ///
    /// - Parameters:
    ///   - name: nib name.
    ///   - bundle: bundle of nib (default is nil).
    /// - Returns: optional UIView (if applicable).
    class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    /// YYSwift: Remove all subviews in view.
    func removeSubviews() {
        subviews.forEach({$0.removeFromSuperview()})
    }
    
    /// YYSwift: Add array of subviews to view.
    ///
    /// - Parameter subviews: array of subviews to add to self.
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({self.addSubview($0)})
    }
    
    /// YYSwift: Fade in view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: completion)
    }
    
    /// YYSwift: Fade out view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    func fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: completion)
    }
    
    /// YYSwift: Remove all gesture recognizers from view.
    func removeGestureRecognizers() {
        gestureRecognizers?.forEach(removeGestureRecognizer)
    }
    
    /// YYSwift: Rotate view by angle on relative axis.
    ///
    /// - Parameters:
    ///   - angle: angle to rotate view by.
    ///   - type: type of the rotation angle.
    ///   - animated: set true to animate rotation (default is true).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func rotate(byAngle angle: CGFloat,
                       ofType type: AngleUnit = .degrees,
                       animated: Bool = false,
                       duration: TimeInterval = 1,
                       completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: { () -> Void in
            self.transform = self.transform.rotated(by: angleWithType)
        }, completion: completion)
    }
    
    /// YYSwift: Rotate view to angle on fixed axis.
    ///
    /// - Parameters:
    ///   - angle: angle to rotate view to.
    ///   - type: type of the rotation angle.
    ///   - animated: set true to animate rotation (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func rotate(toAngle angle: CGFloat,
                       ofType type: AngleUnit = .degrees,
                       animated: Bool = false,
                       duration: TimeInterval = 1,
                       completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, animations: {
            self.transform = self.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
        }, completion: completion)
    }
    
    /// YYSwift: Scale view by offset.
    ///
    /// - Parameters:
    ///   - offset: scale offset
    ///   - animated: set true to animate scaling (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func scale(by offset: CGPoint,
                      animated: Bool = false,
                      duration: TimeInterval = 1,
                      completion: ((Bool) -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: { () -> Void in
                self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
            }, completion: completion)
        } else {
            transform = transform.scaledBy(x: offset.x, y: offset.y)
            completion?(true)
        }
    }
    
    /// YYSwift: Shake view.
    ///
    /// - Parameters:
    ///   - direction: shake direction (horizontal or vertical), (default is .horizontal)
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - animationType: shake animation type (default is .easeOut).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func shake(direction: ShakeDirection = .horizontal,
                      duration: TimeInterval = 1,
                      animationType: ShakeAnimationType = .easeOut,
                      completion:(() -> Void)? = nil) {
        
        CATransaction.begin()
        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        case .vertical:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        }
        switch animationType {
        case .linear:
            animation.timingFunction = CAMediaTimingFunction(name: convertToCAMediaTimingFunctionName(convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.linear)))
        case .easeIn:
            animation.timingFunction = CAMediaTimingFunction(name: convertToCAMediaTimingFunctionName(convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn)))
        case .easeOut:
            animation.timingFunction = CAMediaTimingFunction(name: convertToCAMediaTimingFunctionName(convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeOut)))
        case .easeInOut:
            animation.timingFunction = CAMediaTimingFunction(name: convertToCAMediaTimingFunctionName(convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeInEaseOut)))
        }
        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
    
    /// YYSwift: Add Visual Format constraints.
    ///
    /// - Parameters:
    ///   - withFormat: visual Format language
    ///   - views: array of views which will be accessed starting with index 0 (example: [v0], [v1], [v2]..)
    @available(iOS 9, *)
    func addConstraints(withFormat: String, views: UIView...) {
        var viewsDictionary: [String: UIView] = [:]
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: withFormat, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    /// YYSwift: Anchor all sides of the view into it's superview.
    @available(iOS 9, *)
    func fillToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    /// YYSwift: Add anchors from any side of the current view into the specified anchors and returns the newly added constraints.
    ///
    /// - Parameters:
    ///   - top: current view's top anchor will be anchored into the specified anchor
    ///   - left: current view's left anchor will be anchored into the specified anchor
    ///   - bottom: current view's bottom anchor will be anchored into the specified anchor
    ///   - right: current view's right anchor will be anchored into the specified anchor
    ///   - topConstant: current view's top anchor margin
    ///   - leftConstant: current view's left anchor margin
    ///   - bottomConstant: current view's bottom anchor margin
    ///   - rightConstant: current view's right anchor margin
    ///   - widthConstant: current view's width
    ///   - heightConstant: current view's height
    /// - Returns: array of newly added constraints (if applicable).
    @available(iOS 9, *)
    @discardableResult
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = 0,
        heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors: [NSLayoutConstraint] = []
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    /// YYSwift: Anchor center X into current view's superview with a constant margin value.
    ///
    /// - Parameter constant: constant of the anchor constraint (default is 0).
    @available(iOS 9, *)
    func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    /// YYSwift: Anchor center Y into current view's superview with a constant margin value.
    ///
    /// - Parameter withConstant: constant of the anchor constraint (default is 0).
    @available(iOS 9, *)
    func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    /// YYSwift: Anchor center X and Y into current view's superview
    @available(iOS 9, *)
    func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCAMediaTimingFunctionName(_ input: String) -> CAMediaTimingFunctionName {
	return CAMediaTimingFunctionName(rawValue: input)
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCAMediaTimingFunctionName(_ input: CAMediaTimingFunctionName) -> String {
	return input.rawValue
}
#endif
