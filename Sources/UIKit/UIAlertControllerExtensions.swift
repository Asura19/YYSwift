//
//  UIAlertControllerExtensions.swift
//  YYSwift-iOS
//
//  Created by Phoenix on 2017/12/19.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit
import AudioToolbox

public extension UIAlertController {
    
    public func show(animated: Bool = true, vibrate: Bool = false, completion: (() -> Void)? = nil) {
        
        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: animated, completion: completion)
        if vibrate {
            let device = UIDevice.current
            let initial = device.machineModel?.replace(regex: ",[1-9]", options: [], with: "")
            let version = (initial?.removeAll("iPhone").int)!
            if !UIDevice.current.isPad && version > 8 {
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.prepare()
                generator.impactOccurred()
            }
            else {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
        }
    }
}
