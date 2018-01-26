//
//  UISegmentedControlExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/8.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

// MARK: - Properties
public extension UISegmentedControl {
    
    /// YYSwift: Segments titles.
    public var segmentTitles: [String] {
        get {
            let range = 0..<numberOfSegments
            return range.compactMap { titleForSegment(at: $0) }
        }
        set {
            removeAllSegments()
            for (index, title) in newValue.enumerated() {
                insertSegment(withTitle: title, at: index, animated: false)
            }
        }
    }
    
    /// YYSwift: Segments images.
    public var segmentImages: [UIImage] {
        get {
            let range = 0..<numberOfSegments
            return range.compactMap { imageForSegment(at: $0) }
        }
        set {
            removeAllSegments()
            for (index, image) in newValue.enumerated() {
                insertSegment(with: image, at: index, animated: false)
            }
        }
    }
}
