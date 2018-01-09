//
//  UIScrollViewExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/9.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

public extension UIScrollView {
    
    public func scrollToTop(animated: Bool = true) {
        var off = contentOffset
        off.y = 0 - contentInset.top
        setContentOffset(off, animated: animated)
    }
    
    public func scrollToBottom(animated: Bool = true) {
        var off = contentOffset
        off.y = contentSize.height - bounds.size.height + contentInset.bottom
        setContentOffset(off, animated: animated)
    }
    
    public func scrollToLeft(animated: Bool = true) {
        var off = contentOffset
        off.x = 0 - contentInset.left
        setContentOffset(off, animated: animated)
    }
    
    public func scrollToRight(animated: Bool = true) {
        var off = contentOffset
        off.x = contentSize.width - bounds.size.width + contentInset.right
        setContentOffset(off, animated: animated)
    }
}
