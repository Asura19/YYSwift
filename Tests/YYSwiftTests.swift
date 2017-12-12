//
//  YYSwiftTests.swift
//  YYSwiftTests
//
//  Created by Phoenix on 2017/12/8.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import XCTest
import YYSwift

class YYSwiftTests: XCTestCase {

    
    func testSqrt() {
        XCTAssertEqual(√9.0, 3.0)
    }
    
    func testSum() {
        XCTAssertEqual([1, 2, 3, 4, 5].sum(), 15)
        XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].sum(), 17)

        var h, s, l: CGFloat
        UIColor.yy.RGB2HSL(0.5, 0.2, 0.4, &h, &s, &l)
    }
}
