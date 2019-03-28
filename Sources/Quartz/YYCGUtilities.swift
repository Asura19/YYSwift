//
//  YYCGUtilities.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/26.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

/// YYSwift: Convert CALayerContentsGravity to UIViewContentMode.
public func YYCAGravityToUIViewContentMode(gravity: CALayerContentsGravity) -> UIView.ContentMode {
    let dict: [CALayerContentsGravity: UIView.ContentMode] = [
        .center: .center,
        .top: .top,
        .bottom: .bottom,
        .left: .left,
        .right: .right,
        .topLeft: .topLeft,
        .topRight: .topRight,
        .bottomLeft: .bottomLeft,
        .bottomRight: .bottomRight,
        .resize: .scaleToFill,
        .resizeAspect: .scaleAspectFit,
        .resizeAspectFill: .scaleAspectFill
    ]
    return dict[gravity] ?? .scaleToFill
}

/// YYSwift: Convert UIViewContentMode to CALayerContentsGravity.
public func YYUIViewContentModeToCAGravity(contentMode: UIView.ContentMode) -> CALayerContentsGravity {
    switch contentMode {
    case .scaleToFill:
        return .resize
    case .scaleAspectFit:
        return .resizeAspect
    case .scaleAspectFill:
        return .resizeAspectFill
    case .redraw:
        return .resize
    case .center:
        return .center
    case .top:
        return .top
    case .bottom:
        return .bottom
    case .left:
        return .left
    case .right:
        return .right
    case .topLeft:
        return .topLeft
    case .topRight:
        return .topRight
    case .bottomLeft:
        return .bottomLeft
    case .bottomRight:
        return .bottomRight
    @unknown default:
        return .resize
    }
}

/// YYSwift: Returns a rectangle to fit the @param rect with specified content mode.
///
/// - Parameters:
///   - rect: The constrant rect
///   - size: The content size
///   - mode: The content mode
/// - Returns: A rectangle for the given content mode.
public func YYCGRectFitWithContentMode(rect: CGRect, size: CGSize, mode: UIView.ContentMode) -> CGRect {
    var rect = rect.standardized
    var size = size
    size.width = size.width < 0 ? -size.width : size.width
    size.height = size.height < 0 ? -size.height : size.height
    let center = CGPoint(x: rect.midX, y: rect.midY)
    switch mode {
    case .scaleAspectFit, .scaleAspectFill:
        if (rect.size.width < 0.01 || rect.size.height < 0.01 ||
            size.width < 0.01 || size.height < 0.01) {
            rect.origin = center
            rect.size = CGSize.zero
        }
        else {
            var scale: CGFloat = 0
            if (mode == .scaleAspectFit) {
                if (size.width / size.height < rect.size.width / rect.size.height) {
                    scale = rect.size.height / size.height
                }
                else {
                    scale = rect.size.width / size.width
                }
            }
            else {
                if (size.width / size.height < rect.size.width / rect.size.height) {
                    scale = rect.size.width / size.width
                }
                else {
                    scale = rect.size.height / size.height
                }
            }
            size.width *= scale
            size.height *= scale
            rect.size = size
            rect.origin = CGPoint.init(x: center.x - size.width * 0.5, y: center.y - size.height * 0.5)
        }
    case .center:
        rect.size = size;
        rect.origin = CGPoint.init(x: center.x - size.width * 0.5, y: center.y - size.height * 0.5)
    case .top:
        rect.origin.x = center.x - size.width * 0.5
        rect.size = size
    case .bottom:
        rect.origin.x = center.x - size.width * 0.5
        rect.origin.y += rect.size.height - size.height
        rect.size = size
    case .left:
        rect.origin.y = center.y - size.height * 0.5
        rect.size = size
    case .right:
        rect.origin.y = center.y - size.height * 0.5
        rect.origin.x += rect.size.width - size.width
        rect.size = size
    case .topLeft:
        rect.size = size
    case .topRight:
        rect.origin.x += rect.size.width - size.width
        rect.size = size
    case .bottomLeft:
        rect.origin.y += rect.size.height - size.height
        rect.size = size
    case .bottomRight:
        rect.origin.x += rect.size.width - size.width
        rect.origin.y += rect.size.height - size.height
        rect.size = size
    default:
        break
    }
    return rect
}
#endif
