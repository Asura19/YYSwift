//
//  UISwitchExtensions.swift
//  YYSwift-iOS
//
//  Created by Phoenix on 2017/12/21.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit

// MARK: - Methods
public extension UISwitch {
    
    /// YYSwift: Toggle a UISwitch
    ///
    /// - Parameter animated: set true to animate the change (default is true)
    public func toggle(animated: Bool = true) {
        setOn(!isOn, animated: animated)
    }
}
