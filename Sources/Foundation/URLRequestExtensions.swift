//
//  URLRequestExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/9.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(Foundation)
import Foundation

// MARK: - Initializers
public extension URLRequest {
    
    /// YYSwift: Create URLRequest from URL string.
    ///
    /// - Parameter urlString: URL string to initialize URL request from
    init?(urlString: String) {
        guard let url = URL(string: urlString) else {
            return nil
        }
        self.init(url: url)
    }
    
}
#endif
