//
//  UIImageExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/22.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public var bytesSize: Int {
        return UIImageJPEGRepresentation(self, 1)?.count ?? 0
    }
    
    public var kilobytesSize: Int {
        return bytesSize / 1024
    }
    
    public var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    public var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
}

public extension UIImage {
    
    public func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = compressedData(quality: quality) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    public func compressedData(quality: CGFloat = 0.5) -> Data? {
        return UIImageJPEGRepresentation(self, quality)
    }
    
    public func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.height < size.height && rect.size.width < size.width else {
            return self
        }
        guard let image: CGImage = cgImage?.cropping(to: rect) else {
            return self
        }
        return UIImage(cgImage: image)
    }
    
    public func scaled(toHeight: CGFloat, with orientation: UIImageOrientation? = nil) -> UIImage? {
        let scale = toHeight / size.height
        let newWidth = size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: toHeight))
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
}

public extension UIImage {
    
    public class func image(withSmallGIFData data: Data, scale: CGFloat) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        let count = CGImageSourceGetCount(source)
        if count <= 1 {
            return UIImage.init(data: data, scale: scale)
        }
        var frames = [Int](repeating: 0, count: count)
        let oneFrameTime = 1 / 50.0
        var totalTime: TimeInterval = 0
        var totalFrame: Int = 0
        var gcdFrame: Int = 0
        for i in 0..<count {
            let delay: TimeInterval = getGIFFrameDelay(with: source, index: i)
            totalTime += delay
            var frame = lrint(delay / oneFrameTime)
            if frame < 1 {
                frame = 1
            }
            frames[i] = frame
            totalFrame += frames[i]
            if i == 0 {
                gcdFrame = frames[i]
            }
            else {
                var frame = frames[i]
                var temp: Int
                if frame < gcdFrame {
                    temp = frame
                    frame = gcdFrame
                    gcdFrame = temp
                }
                while true {
                    temp = frame % gcdFrame
                    if temp == 0 {
                        break
                    }
                    frame = gcdFrame
                    gcdFrame = temp
                }
            }
        }
        var array = [UIImage]()
        for i in 0..<count {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else {
                return nil
            }
            let width = cgImage.width
            let height = cgImage.height
            if width == 0 || height == 0 {
                return nil
            }
            let alphaInfo = cgImage.alphaInfo
            var hasAlpha = false
            if alphaInfo == .premultipliedLast ||
                alphaInfo == .premultipliedFirst ||
                alphaInfo == .last ||
                alphaInfo == .first {
                hasAlpha = true
            }
            var bitmapInfo = CGBitmapInfo.byteOrder32Little
            let rawValue = UInt32(hasAlpha ? CGImageAlphaInfo.premultipliedFirst.rawValue : CGImageAlphaInfo.noneSkipFirst.rawValue) | bitmapInfo.rawValue
            bitmapInfo = CGBitmapInfo.init(rawValue: rawValue)
            let space = CGColorSpaceCreateDeviceRGB()
            guard let context = CGContext.init(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: space, bitmapInfo: bitmapInfo.rawValue) else {
                return nil
            }
            context.draw(cgImage, in: CGRect.init(x: 0, y: 0, width: width, height: height))
            guard let decoded = context.makeImage() else {
                return nil
            }
            
            guard let image = uiImage(with: decoded, scale: scale, orientation: .up) else {
                return nil
            }
            let max = frames[i] / gcdFrame
            for _ in 0..<max {
                array.append(image)
            }
        }
        return UIImage.animatedImage(with: array, duration: totalTime)
    }
    
    public class func isAnimated(withGIFData data: Data) -> Bool {
        if data.count < 16 {
            return false
        }
        guard let source: CGImageSource = CGImageSourceCreateWithData(data as CFData, nil), CGImageSourceGetCount(source) > 1 else {
            return false
        }
        return true
    }
    
    public class func image(withPDF dataOrPath: Any) -> UIImage? {
        return image(withPDF: dataOrPath, resize: false, size: CGSize.zero)
    }
    
    public class func image(withPDF dataOrPath: Any, size: CGSize) -> UIImage? {
        return image(withPDF: dataOrPath, resize: true, size: size)
    }
    
    public class func image(withPDF dataOrPath: Any, resize: Bool, size: CGSize) -> UIImage? {
        var pdf: CGPDFDocument?
        if dataOrPath is Data {
            let provider = CGDataProvider(data: dataOrPath as! CFData)
            pdf = CGPDFDocument.init(provider!)
        }
        else if dataOrPath is String {
            pdf = CGPDFDocument.init(URL(fileURLWithPath: dataOrPath as! String) as CFURL)
        }
        if pdf == nil {
            return nil
        }
        guard let page = pdf?.page(at: 1) else {
            return nil
        }
        let pdfRect = page.getBoxRect(.cropBox)
        let pdfSize = resize ? size : pdfRect.size
        let scale = UIScreen.main.scale
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext.init(data: nil,
                                     width: Int(pdfSize.width * scale),
                                     height: Int(pdfSize.height * scale),
                                     bitsPerComponent: 8,
                                     bytesPerRow: 0,
                                     space: colorSpace,
                                     bitmapInfo: CGImageByteOrderInfo.orderMask.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        if context == nil {
            return nil
        }
        context?.scaleBy(x: scale, y: scale)
        context?.translateBy(x: -pdfRect.origin.x, y: -pdfRect.origin.y)
        context?.drawPDFPage(page)
        guard let image = context?.makeImage() else {
            return nil
        }
        return UIImage.init(cgImage: image, scale: scale, orientation: .up)
    }
}

fileprivate func uiImage(with cgImage: CGImage, scale: CGFloat, orientation: UIImageOrientation) -> UIImage? {
    return UIImage(cgImage: cgImage, scale: scale, orientation: orientation)
}

fileprivate func convertToDelay(_ pointer:UnsafeRawPointer?) -> Float? {
    if pointer == nil {
        return nil
    }
    let value = unsafeBitCast(pointer, to:AnyObject.self)
    return value.floatValue
}

fileprivate func getGIFFrameDelay(with source: CGImageSource, index: Int) -> TimeInterval {
    var delay: TimeInterval = 0
    if let dic = CGImageSourceCopyProperties(source, nil) {
        
        let key = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
        let value = CFDictionaryGetValue(dic, key)
        
        let dicGIF: CFDictionary
        if value != nil {
            dicGIF = unsafeBitCast(value, to: CFDictionary.self)
            let unclampedKey = Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()
            
            let unclampedPointer: UnsafeRawPointer? = CFDictionaryGetValue(dicGIF, unclampedKey)
            if let value = convertToDelay(unclampedPointer), value > Float.ulpOfOne {
                delay = TimeInterval(value.double)
            }
            
            let clampedKey = Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()
            let clampedPointer: UnsafeRawPointer? = CFDictionaryGetValue(dicGIF, clampedKey)
            if let value = convertToDelay(clampedPointer) {
                delay = TimeInterval(value.double)
            }
        }
    }
    if delay < 0.02 {
        delay = 0.1
    }
    return delay
}

