//
//  UIScrollViewExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/9.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Methods
public extension UIScrollView {
    
    /// YYSwift: Takes a snapshot of an entire ScrollView
    ///
    ///    AnySubclassOfUIScroolView().snapshot
    ///    UITableView().snapshot
    ///
    /// - Returns: Snapshot as UIimage for rendered ScrollView
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// YYSwift: Scroll content to top.
    ///
    /// - Parameter animated: Use animation (default is true).
    func scrollToTop(animated: Bool = true) {
        var off = contentOffset
        off.y = 0 - contentInset.top
        setContentOffset(off, animated: animated)
    }
    
    /// YYSwift: Scroll content to bottom.
    ///
    /// - Parameter animated: Use animation (default is true).
    func scrollToBottom(animated: Bool = true) {
        var off = contentOffset
        off.y = contentSize.height - bounds.size.height + contentInset.bottom
        setContentOffset(off, animated: animated)
    }
    
    /// YYSwift: Scroll content to left.
    ///
    /// - Parameter animated: Use animation (default is true).
    func scrollToLeft(animated: Bool = true) {
        var off = contentOffset
        off.x = 0 - contentInset.left
        setContentOffset(off, animated: animated)
    }
    
    /// YYSwift: Scroll content to right.
    ///
    /// - Parameter animated: Use animation (default is true).
    func scrollToRight(animated: Bool = true) {
        var off = contentOffset
        off.x = contentSize.width - bounds.size.width + contentInset.right
        setContentOffset(off, animated: animated)
    }
    
}
#endif
