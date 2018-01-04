//
//  UIImageExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/22.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit
import Accelerate

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
    
    public var roatateLeft90: UIImage? {
        return self.rotate(byRadians: CGFloat(90.0).degreesToRadians, fitSize: true)
    }
    
    public var roatateRight90: UIImage? {
        return self.rotate(byRadians: CGFloat(-90.0).degreesToRadians, fitSize: true)
    }
    
    public var roatate180: UIImage? {
        return self.flip(horizontal: true, vertical: true)
    }
    
    public var flipVertical: UIImage? {
        return self.flip(horizontal: false, vertical: true)
    }
    
    public var flipHorizontal: UIImage? {
        return self.flip(horizontal: true, vertical: false)
    }
    
    public var grayscale: UIImage? {
        return self.applyBlur(byRadius: 0, tintColor: nil, tintBlendMode: .normal, saturation: 0, maskImage: nil)
    }
    
    public var blurSoft: UIImage? {
        return self.applyBlur(byRadius: 60, tintColor: UIColor.init(white: 0.84, alpha: 0.36), tintBlendMode: .normal, saturation: 1.8, maskImage: nil)
    }
    
    public var blurLight: UIImage? {
        return self.applyBlur(byRadius: 60, tintColor: UIColor.init(white: 1.0, alpha: 0.3), tintBlendMode: .normal, saturation: 1.8, maskImage: nil)
    }
    
    public var blurExtraLight: UIImage? {
        return self.applyBlur(byRadius: 40, tintColor: UIColor.init(white: 0.97, alpha: 0.82), tintBlendMode: .normal, saturation: 1.8, maskImage: nil)
    }
    
    public var blurDark: UIImage? {
        return self.applyBlur(byRadius: 40, tintColor: UIColor.init(white: 0.11, alpha: 0.73), tintBlendMode: .normal, saturation: 1.8, maskImage: nil)
    }
    
    
    public var hasAlphaChannel: Bool {
        guard let cgImage = self.cgImage else {
            return false
        }
        let alpha = CGImageAlphaInfo.init(rawValue: cgImage.alphaInfo.rawValue & CGBitmapInfo.alphaInfoMask.rawValue)
        return (alpha == .first ||
            alpha == .last ||
            alpha == .premultipliedFirst ||
            alpha == .premultipliedLast)
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
        var rect = rect
        rect.origin.x *= self.scale
        rect.origin.y *= self.scale
        rect.size.width *= self.scale
        rect.size.height *= self.scale
        
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
    
    public func setEdge(byInsets insets: UIEdgeInsets, color: UIColor) -> UIImage? {
        var size = self.size
        size.width -= insets.left + insets.right
        size.height -= insets.top + insets.bottom
        if size.width <= 0 || size.height <= 0 { return nil }
        let rect = CGRect.init(x: -insets.left, y: -insets.top, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(color.cgColor)
        let path = CGMutablePath()
        path.addRect(CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        path.addRect(rect)
        context.addPath(path)
        context.fillPath()
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public func setRoundCorner(with radius: CGFloat, corners: UIRectCorner = .allCorners, borderWidth: CGFloat = 0, borderColor: UIColor? = nil, borderLineJoin: CGLineJoin = .miter) -> UIImage {
        var corners = corners
        if corners != .allCorners && corners.contains(.allCorners) {
            corners.remove(.allCorners)
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -rect.size.height)
        
        let minSize = min(self.size.width, self.size.height)
        if borderWidth < minSize / 2 {
            let path = UIBezierPath(roundedRect: rect.insetBy(dx: borderWidth, dy: borderWidth), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: borderWidth))
            path.close()
            context.saveGState()
            path.addClip()
            guard let cgImage = self.cgImage else { return self }
            context.draw(cgImage, in: rect)
            context.restoreGState()
        }
        
        if borderColor != nil && borderWidth < minSize / 2 && borderWidth > 0 {
            let strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale
            let strokeRect = rect.insetBy(dx: strokeInset, dy: strokeInset)
            let strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0
            let path = UIBezierPath(roundedRect: strokeRect, byRoundingCorners: corners, cornerRadii: CGSize(width: strokeRadius, height: borderWidth))
            path.close()
            path.lineWidth = borderWidth
            path.lineJoinStyle = borderLineJoin
            borderColor!.setStroke()
            path.stroke()
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if newImage != nil {
            return newImage!
        }
        else {
            return self
        }
    }
    
    public func rotate(byRadians radians: CGFloat, fitSize: Bool) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let width = cgImage.width
        let height = cgImage.height
        let newRect = CGRect(x: 0, y: 0, width: width, height: height).applying(fitSize ? CGAffineTransform.init(rotationAngle: radians) : .identity)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext.init(data: nil,
                                           width: newRect.size.width.int,
                                           height: newRect.size.height.int,
                                           bitsPerComponent: 8,
                                           bytesPerRow: newRect.size.width.int * 4,
                                           space: colorSpace,
                                           bitmapInfo: CGImageByteOrderInfo.orderMask.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue) else {
                                            return nil
        }
        context.setShouldAntialias(true)
        context.setAllowsAntialiasing(true)
        context.interpolationQuality = .high
        
        context.translateBy(x: +(newRect.size.width * 0.5), y: +(newRect.size.height * 0.5))
        context.rotate(by: radians)
        context.draw(cgImage, in: CGRect(x: -(width.cgFloat * 0.5), y: -(height.cgFloat * 0.5), width: width.cgFloat, height: height.cgFloat))
        guard let image = context.makeImage() else { return nil }
        return UIImage(cgImage: image, scale: self.scale, orientation: self.imageOrientation)
    }
    
    private func flip(horizontal: Bool, vertical: Bool) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerRow = width * 4
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext.init(data: nil,
                                           width: width,
                                           height: height,
                                           bitsPerComponent: 8,
                                           bytesPerRow: bytesPerRow,
                                           space: colorSpace,
                                           bitmapInfo: CGImageByteOrderInfo.orderMask.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue) else {
                                            return nil
        }
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        guard let data = context.data else { return nil }
        var src = vImage_Buffer(data: data, height: vImagePixelCount(width), width: vImagePixelCount(height), rowBytes: bytesPerRow)
        var dest = vImage_Buffer(data: data, height: vImagePixelCount(width), width: vImagePixelCount(height), rowBytes: bytesPerRow)
        if vertical {
            vImageVerticalReflect_ARGB8888(&src, &dest, vImage_Flags(kvImageBackgroundColorFill))
        }
        if horizontal {
            vImageHorizontalReflect_ARGB8888(&src, &dest, vImage_Flags(kvImageBackgroundColorFill))
        }
        guard let image = context.makeImage() else { return nil }
        return UIImage(cgImage: image, scale: self.scale, orientation: self.imageOrientation)
    }
    
    public func tint(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        color.set()
        UIRectFill(rect)
        self.draw(at: CGPoint.zero, blendMode: .destinationIn, alpha: 1)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if newImage != nil {
            return newImage!
        }
        else {
            return self
        }
    }
    
    public func applyBlur(withTintColor tintColor: UIColor) -> UIImage? {
        let effectColorAlpha: CGFloat = 0.6
        var effectColor = tintColor
        let componentCount = tintColor.cgColor.numberOfComponents
        if componentCount == 2 {
            var b: CGFloat = 0
            if tintColor.getWhite(&b, alpha: nil) {
                effectColor = UIColor(white: b, alpha: effectColorAlpha)
            }
        }
        else {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            if tintColor.getRed(&r, green: &g, blue: &b, alpha: nil) {
                effectColor = UIColor(red: r, green: g, blue: b, alpha: effectColorAlpha)
            }
        }
        return self.applyBlur(byRadius: 20, tintColor: effectColor, tintBlendMode: .normal, saturation: -1.0, maskImage: nil)
    }
    
    public func applyBlur(byRadius blurRadius: CGFloat, tintColor: UIColor? = nil, tintBlendMode: CGBlendMode, saturation: CGFloat, maskImage: UIImage? = nil) -> UIImage? {
        guard  self.size.width > 1,
               self.size.height > 1,
               let cgImage = self.cgImage,
               maskImage != nil else {
                return nil
        }
        let hasBlur = blurRadius > CGFloat.ulpOfOne
        let hasSaturation = fabs(saturation - 1.0) > CGFloat.ulpOfOne
        
        let scale = self.scale
        let opaque = false
        
        if !hasBlur && !hasSaturation {
            return self.merge(effectCGImage: cgImage, tintColor: tintColor, tintBlendMode: tintBlendMode, maskImage: maskImage, opaque: opaque)
        }
        
        var effect = vImage_Buffer()
        var scratch = vImage_Buffer()
        
        var format = vImage_CGImageFormat(
            bitsPerComponent: 8,
            bitsPerPixel: 32,
            colorSpace: nil,
            bitmapInfo: CGBitmapInfo.init(rawValue: CGImageByteOrderInfo.order32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue),
            version: 0,
            decode: nil,
            renderingIntent: .defaultIntent
        )
        var error = vImageBuffer_InitWithCGImage(&effect, &format, nil, cgImage, vImage_Flags(kvImagePrintDiagnosticsToConsole))
        if error != kvImageNoError {
            return nil
        }
        error = vImageBuffer_Init(&scratch, effect.width, effect.height, format.bitsPerPixel, vImage_Flags(kvImageNoFlags))
        if error != kvImageNoError {
            return nil
        }
        
        var input = effect
        var output = scratch
        
        if hasBlur {
            var inputRadius = blurRadius * scale
            if inputRadius - 2.0 < CGFloat.ulpOfOne {
                inputRadius = 2.0
            }
            let radiusFloat = floor((inputRadius * 3.0 * sqrt(2 * CGFloat.pi) / 4 + 0.5) / 2)
            let radius = UInt32(radiusFloat) | 1
            var iterations: Int = 0
            if blurRadius * scale < 0.5 { iterations = 1 }
            else if blurRadius * scale < 1.5 { iterations = 2 }
            else { iterations = 3 }
            let tempSize = vImageBoxConvolve_ARGB8888(&input, &output, nil, 0, 0, radius, radius, nil, vImage_Flags(kvImageGetTempBufferSize | kvImageEdgeExtend))
            guard let temp = malloc(tempSize) else { return nil }
            for _ in 0..<iterations {
                vImageBoxConvolve_ARGB8888(&input, &output, temp, 0, 0, radius, radius, nil, vImage_Flags(kvImageEdgeExtend))
                swap(&input, &output)
            }
            free(temp)
        }
        
        if hasSaturation {
            let s = saturation
            let matrixFloat: [CGFloat] = [
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,                    1,
            ]
            let divisor: Int32 = 256
            let matrixSize = MemoryLayout.size(ofValue: matrixFloat) / MemoryLayout.size(ofValue: matrixFloat[0])
            var matrix = [Int16](repeating: 0, count: matrixSize)
            for i in 0..<matrixSize {
                matrix[i] = Int16(roundf(Float(matrixFloat[i] * CGFloat(divisor))))
            }
            vImageMatrixMultiply_ARGB8888(&input, &output, &matrix, divisor, nil, nil, vImage_Flags(kvImageNoFlags))
            swap(&input, &output)
        }
        
        var effectCGImage = vImageCreateCGImageFromBuffer(&input, &format, { free($1) }, nil, vImage_Flags(kvImageNoAllocate), nil)
        
        if effectCGImage == nil {
            effectCGImage = vImageCreateCGImageFromBuffer(&input, &format, nil, nil, vImage_Flags(kvImageNoFlags), nil)
            free(&input.data)
        }
        free(&output.data)
        return self.merge(effectCGImage: effectCGImage!.takeUnretainedValue(), tintColor: tintColor, tintBlendMode: tintBlendMode, maskImage: maskImage, opaque: opaque)
    }
    
    private func merge(effectCGImage: CGImage, tintColor: UIColor? = nil, tintBlendMode: CGBlendMode, maskImage: UIImage? = nil, opaque: Bool) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let hasTint: Bool = tintColor != nil && tintColor!.cgColor.alpha > CGFloat.ulpOfOne
        let hasMask: Bool = maskImage != nil
        let size = self.size
        let rect = CGRect(origin: .zero, size: size)
        let scale = self.scale
        
        if !hasTint && !hasMask {
            return UIImage(cgImage: effectCGImage)
        }
        
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -size.height)
        if hasMask {
            context.draw(cgImage, in: rect)
            context.saveGState()
            context.clip(to: rect, mask: maskImage!.cgImage!)
        }
        context.draw(effectCGImage, in: rect)
        if hasTint {
            context.saveGState()
            context.setBlendMode(tintBlendMode)
            context.setFillColor(tintColor!.cgColor)
            context.fill(rect)
            context.restoreGState()
        }
        if hasMask {
            context.restoreGState()
        }
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if outputImage != nil {
            return outputImage!
        }
        else {
            return nil
        }
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
    
    private class func image(withPDF dataOrPath: Any, resize: Bool, size: CGSize) -> UIImage? {
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
    
    public class func image(withEmoji emoji: String, size: CGFloat) -> UIImage? {
        if emoji.count == 0 || size < 1 {
            return nil
        }
        let scale = UIScreen.main.scale
        let font = CTFontCreateWithName("AppleColorEmoji" as CFString, size * scale, nil)
        let str = NSAttributedString(string: emoji, attributes: [kCTFontAttributeName as NSAttributedStringKey: font, kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.white.cgColor])
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext.init(data: nil,
                                     width: Int(size * scale),
                                     height: Int(size * scale),
                                     bitsPerComponent: 8,
                                     bytesPerRow: 0,
                                     space: colorSpace,
                                     bitmapInfo: CGImageByteOrderInfo.orderMask.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        if context == nil {
            return nil
        }
        context!.interpolationQuality = .high
        let line = CTLineCreateWithAttributedString(str as CFAttributedString)
        let bounds = CTLineGetBoundsWithOptions(line, .useGlyphPathBounds)
        context!.textPosition = CGPoint(x: 0, y: -bounds.origin.y)
        CTLineDraw(line, context!)
        guard let cgImage = context?.makeImage() else {
            return nil
        }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .up)
    }
    
    public class func image(withColor color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public class func image(withSize size: CGSize, drawBlock: (CGContext) -> Void) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        drawBlock(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func draw(inRect rect: CGRect, contentMode: UIViewContentMode, clipsToBounds: Bool) {
        let drawRect = YYCGRectFitWithContentMode(rect: rect, size: self.size, mode: contentMode)
        if drawRect.size.width == 0 || drawRect.size.height == 0 {
            return
        }
        if clipsToBounds {
            guard let context = UIGraphicsGetCurrentContext() else {
                return
            }
            context.saveGState()
            context.addRect(rect)
            context.clip()
            self.draw(in: drawRect)
            context.restoreGState()
        }
        else {
            self.draw(in: drawRect)
        }
    }
    
    public func resize(to size: CGSize) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func resize(to size: CGSize, contentMode: UIViewContentMode) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(inRect: CGRect.init(x: 0, y: 0, width: size.width, height: size.height), contentMode: contentMode, clipsToBounds: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

fileprivate func uiImage(with cgImage: CGImage, scale: CGFloat, orientation: UIImageOrientation) -> UIImage? {
    return UIImage(cgImage: cgImage, scale: scale, orientation: orientation)
}

fileprivate func convertToDelay(_ pointer: UnsafeRawPointer?) -> Float? {
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

