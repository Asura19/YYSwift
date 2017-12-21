//
//  UISwitchExtensions.swift
//  YYSwift-iOS
//
//  Created by Phoenix on 2017/12/21.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit

public extension UISwitch {
    
    public func toggle(animated: Bool = true) {
        setOn(!isOn, animated: animated)
    }
}
