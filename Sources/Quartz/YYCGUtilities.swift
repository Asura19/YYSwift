//
//  YYCGUtilities.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/26.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit

public func YYCAGravityToUIViewContentMode(gravity: String) -> UIViewContentMode {
    let dict: [String: UIViewContentMode] = [
        kCAGravityCenter: .center,
        kCAGravityTop: .top,
        kCAGravityBottom: .bottom,
        kCAGravityLeft: .left,
        kCAGravityRight: .right,
        kCAGravityTopLeft: .topLeft,
        kCAGravityTopRight: .topRight,
        kCAGravityBottomLeft: .bottomLeft,
        kCAGravityBottomRight: .bottomRight,
        kCAGravityResize: .scaleToFill,
        kCAGravityResizeAspect: .scaleAspectFit,
        kCAGravityResizeAspectFill: .scaleAspectFill
    ]
    return dict[gravity] ?? .scaleToFill
}

public func YYUIViewContentModeToCAGravity(contentMode: UIViewContentMode) -> String {
    switch contentMode {
    case .scaleToFill:
        return kCAGravityResize
    case .scaleAspectFit:
        return kCAGravityResizeAspect
    case .scaleAspectFill:
        return kCAGravityResizeAspectFill
    case .redraw:
        return kCAGravityResize
    case .center:
        return kCAGravityCenter
    case .top:
        return kCAGravityTop
    case .bottom:
        return kCAGravityBottom
    case .left:
        return kCAGravityLeft
    case .right:
        return kCAGravityRight
    case .topLeft:
        return kCAGravityTopLeft
    case .topRight:
        return kCAGravityTopRight
    case .bottomLeft:
        return kCAGravityBottomLeft
    case .bottomRight:
        return kCAGravityBottomRight
    }
}

public func YYCGRectFitWithContentMode(rect: CGRect, size: CGSize, mode: UIViewContentMode) -> CGRect {
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
