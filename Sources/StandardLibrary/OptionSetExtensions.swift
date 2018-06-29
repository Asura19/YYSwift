//
//  OptionSetExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/20.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

public extension OptionSet where RawValue: FixedWidthInteger {
    
    // https://stackoverflow.com/questions/32102936/how-do-you-enumerate-optionsettype-in-swift
    
    /// YYSwift: Return a sequence of OptionSet
    ///
    /// - Returns: a sequence of OptionSet
    func elements() -> AnySequence<Self> {
        var remainingBits = rawValue
        var bitMask: RawValue = 1
        return AnySequence {
            return AnyIterator {
                while remainingBits != 0 {
                    defer { bitMask = bitMask &* 2 }
                    if remainingBits & bitMask != 0 {
                        remainingBits = remainingBits & ~bitMask
                        return Self(rawValue: bitMask)
                    }
                }
                return nil
            }
        }
    }
}
