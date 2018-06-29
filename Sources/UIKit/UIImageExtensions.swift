//
//  UIImageExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/22.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if canImport(Accelerate)
import Accelerate
#endif

// MARK: - Properties
public extension UIImage {
    
    /// YYSwift: Size in bytes of UIImage
    public var bytesSize: Int {
        return self.jpegData(compressionQuality: 1)?.count ?? 0
    }
    
    /// YYSwift: Size in kilo bytes of UIImage
    public var kilobytesSize: Int {
        return bytesSize / 1024
    }
    
    /// YYSwift: UIImage with .alwaysOriginal rendering mode.
    public var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    /// YYSwift: UIImage with .alwaysTemplate rendering mode.
    public var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
    
    /// YYSwift: A new image rotated counterclockwise by a quarter‑turn (90°). ⤺
    /// The width and height will be exchanged.
    public var roatateLeft90: UIImage? {
        return self.rotate(byRadians: CGFloat(90.0).degreesToRadians, fitSize: true)
    }
    
    /// YYSwift: A new image rotated clockwise by a quarter‑turn (90°). ⤼
    /// The width and height will be exchanged.
    public var roatateRight90: UIImage? {
        return self.rotate(byRadians: CGFloat(-90.0).degreesToRadians, fitSize: true)
    }
    
    #if canImport(Accelerate)
    /// YYSwift: A new image rotated 180° . ↻
    public var roatate180: UIImage? {
        return self.flip(horizontal: true, vertical: true)
    }
    
    /// YYSwift: A vertically flipped image. ⥯
    public var flipVertical: UIImage? {
        return self.flip(horizontal: false, vertical: true)
    }
    
    /// YYSwift: A horizontally flipped image. ⇋
    public var flipHorizontal: UIImage? {
        return self.flip(horizontal: true, vertical: false)
    }
    #endif
    
    /// YYSwift: A grayscaled image.
    public var grayscale: UIImage? {
        return self.appliedBlur(radius: 0, tintColor: nil, tintBlendMode: .normal, saturation: 0, maskImage: nil)
    }
    
    /// YYSwift: Applies a blur effect to this image. Suitable for blur any content.
    public var blurSoft: UIImage? {
        return self.appliedBlur(radius: 60, tintColor: UIColor.init(white: 0.84, alpha: 0.36), tintBlendMode: .normal, saturation: 1.8, maskImage: nil)
    }
    
    /// YYSwift: Applies a blur effect to this image. Suitable for blur any content except pure white.
    /// (same as iOS Control Panel)
    public var blurLight: UIImage? {
        return self.appliedBlur(radius: 60, tintColor: UIColor.init(white: 1.0, alpha: 0.3), tintBlendMode: .normal, saturation: 1.8, maskImage: nil)
    }
    
    /// YYSwift: Applies a blur effect to this image. Suitable for displaying black text.
    /// (same as iOS Navigation Bar White)
    public var blurExtraLight: UIImage? {
        return self.appliedBlur(radius: 40, tintColor: UIColor.init(white: 0.97, alpha: 0.82), tintBlendMode: .normal, saturation: 1.8, maskImage: nil)
    }
    
    /// YYSwift: Applies a blur effect to this image. Suitable for displaying white text.
    /// (same as iOS Notification Center)
    public var blurDark: UIImage? {
        return self.appliedBlur(radius: 40, tintColor: UIColor.init(white: 0.11, alpha: 0.73), tintBlendMode: .normal, saturation: 1.8, maskImage: nil)
    }
    
    /// YYSwift: Whether this image has alpha channel.
    public var hasAlphaChannel: Bool {
        guard let cgImage = self.cgImage else {
            return false
        }
        let alpha = CGImageAlphaInfo.init(rawValue: cgImage.alphaInfo.rawValue & CGBitmapInfo.alphaInfoMask.rawValue)
        return (alpha == .first
            || alpha == .last
            || alpha == .premultipliedFirst
            || alpha == .premultipliedLast)
    }
}

// MARK: - Methods
public extension UIImage {
    
    /// YYSwift: Compressed UIImage from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional UIImage (if applicable).
    public func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = compressedData(quality: quality) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    /// YYSwift: Compressed UIImage data from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional Data (if applicable).
    public func compressedData(quality: CGFloat = 0.5) -> Data? {
        return self.jpegData(compressionQuality: quality)
    }
    
    /// YYSwift: UIImage Cropped to CGRect.
    ///
    /// - Parameter rect: CGRect to crop UIImage to.
    /// - Returns: cropped UIImage
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
    
    /// YYSwift: UIImage scaled to height with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toHeight: new height.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    ///   - orientation: optional UIImage orientation (default is nil).
    /// - Returns: optional scaled UIImage (if applicable).
    public func scaled(toHeight: CGFloat, opaque: Bool = false, with orientation: UIImage.Orientation? = nil) -> UIImage? {
        let scale = toHeight / size.height
        let newWidth = size.width * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: toHeight), opaque, scale)
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// YYSwift: UIImage scaled to width with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toWidth: new width.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    ///   - orientation: optional UIImage orientation (default is nil).
    /// - Returns: optional scaled UIImage (if applicable).
    public func scaled(toWidth: CGFloat, opaque: Bool = false, with orientation: UIImage.Orientation? = nil) -> UIImage? {
        let scale = toWidth / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: newHeight), opaque, scale)
        draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// YYSwift: Returns a new image which is edge inset from this image.
    ///
    /// - Parameters:
    ///   - insets: Inset (positive) for each of the edges, values can be negative to 'outset'.
    ///   - color: Extend edge's fill color, nil means clear color.
    /// - Returns: The new image
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
    
    /// YYSwift: Rounds a new image with a given corner size.
    ///
    /// - Parameters:
    ///   - radius: The radius of each corner oval. Values larger than half the
    ///             rectangle's width or height are clamped appropriately to
    ///             half the width or height.
    ///   - corners: A bitmask value that identifies the corners that you want
    ///              rounded. You can use this parameter to round only a subset
    ///              of the corners of the rectangle.
    ///   - borderWidth: The inset border line width. Values larger than half
    ///                  the rectangle's width or height are clamped
    ///                  appropriately to half the width or height.
    ///   - borderColor: The border stroke color. nil means clear color.
    ///   - borderLineJoin: The border line join.
    /// - Returns: The new image
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
            guard let cgImage = self.cgImage else {
                return self
            }
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
    
    /// YYSwift: Returns a new rotated image (relative to the center).
    ///
    /// - Parameters:
    ///   - radians: Rotated radians in counterclockwise.⟲
    ///   - fitSize: true: new image's size is extend to fit all content.
    ///              false: image's size will not change, content may be clipped.
    /// - Returns: The new image
    public func rotate(byRadians radians: CGFloat, fitSize: Bool) -> UIImage? {
        guard let cgImage = self.cgImage else {
            return nil
        }
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
        guard let image = context.makeImage() else {
            return nil
        }
        return UIImage(cgImage: image, scale: self.scale, orientation: self.imageOrientation)
    }
    
    #if canImport(Accelerate)
    private func flip(horizontal: Bool, vertical: Bool) -> UIImage? {
        guard let cgImage = self.cgImage else {
            return nil
        }
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
        guard let data = context.data else {
            return nil
        }
        var src = vImage_Buffer(data: data, height: vImagePixelCount(width), width: vImagePixelCount(height), rowBytes: bytesPerRow)
        var dest = vImage_Buffer(data: data, height: vImagePixelCount(width), width: vImagePixelCount(height), rowBytes: bytesPerRow)
        if vertical {
            vImageVerticalReflect_ARGB8888(&src, &dest, vImage_Flags(kvImageBackgroundColorFill))
        }
        if horizontal {
            vImageHorizontalReflect_ARGB8888(&src, &dest, vImage_Flags(kvImageBackgroundColorFill))
        }
        guard let image = context.makeImage() else {
            return nil
        }
        return UIImage(cgImage: image, scale: self.scale, orientation: self.imageOrientation)
    }
    #endif
    
    /// YYSwift: UIImage tinted with color
    ///
    /// - Parameter color: color to tint image with.
    /// - Returns: UIImage tinted with given color.
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
    
    /// YYSwift: Applies a blur and tint color to this image.
    ///
    /// - Parameter tintColor: The tint color.
    /// - Returns: The new image
    public func applyBlurWithTintColor(_ tintColor: UIColor) -> UIImage? {
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
        return self.appliedBlur(radius: 20, tintColor: effectColor, tintBlendMode: .normal, saturation: -1.0, maskImage: nil)
    }
    
    #if canImport(Accelerate)
    /// YYSwift: Applies a blur, tint color, and saturation adjustment to this image,
    /// optionally within the area specified by @a maskImage.
    ///
    /// - Parameters:
    ///   - radius: The radius of the blur in points, 0 means no blur effect.
    ///   - tintColor: An optional UIColor object that is uniformly blended with
    ///                the result of the blur and saturation operations. The
    ///                alpha channel of this color determines how strong the
    ///                tint is. nil means no tint.
    ///   - tintBlendMode: The @a tintColor blend mode.
    ///                    Default is CGBlendMode.normal.
    ///   - saturation: A value of 1.0 produces no change in the resulting image.
    ///                 Values less than 1.0 will desaturation the resulting image
    ///                 while values greater than 1.0 will have the opposite effect.
    ///                 0 means gray scale.
    ///   - maskImage: If specified, @a inputImage is only modified in the area(s)
    ///                defined by this mask.  This must be an image mask or it
    ///                must meet the requirements of the mask parameter of
    ///                CGContextClipToMask.
    /// - Returns: The blured new Image
    public func appliedBlur(radius: CGFloat,
                            tintColor: UIColor? = nil,
                            tintBlendMode: CGBlendMode,
                            saturation: CGFloat,
                            maskImage: UIImage? = nil) -> UIImage? {
        guard  self.size.width > 1,
               self.size.height > 1,
               let cgImage = self.cgImage,
               maskImage != nil else {
                return nil
        }
        let hasBlur = radius > CGFloat.ulpOfOne
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
            var inputRadius = radius * scale
            if inputRadius - 2.0 < CGFloat.ulpOfOne {
                inputRadius = 2.0
            }
            let radiusFloat = floor((inputRadius * 3.0 * sqrt(2 * CGFloat.pi) / 4 + 0.5) / 2)
            let radiusInt = UInt32(radiusFloat) | 1
            var iterations: Int = 0
            if radius * scale < 0.5 { iterations = 1 }
            else if radius * scale < 1.5 { iterations = 2 }
            else { iterations = 3 }
            let tempSize = vImageBoxConvolve_ARGB8888(&input, &output, nil, 0, 0, radiusInt, radiusInt, nil, vImage_Flags(kvImageGetTempBufferSize | kvImageEdgeExtend))
            guard let temp = malloc(tempSize) else {
                return nil
            }
            for _ in 0..<iterations {
                vImageBoxConvolve_ARGB8888(&input, &output, temp, 0, 0, radiusInt, radiusInt, nil, vImage_Flags(kvImageEdgeExtend))
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
    #endif
    
    private func merge(effectCGImage: CGImage, tintColor: UIColor? = nil, tintBlendMode: CGBlendMode, maskImage: UIImage? = nil, opaque: Bool) -> UIImage? {
        guard let cgImage = self.cgImage else {
            return nil
        }
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

// MARK: - Static Initializer Method
public extension UIImage {
    
    /// YYSwift: Create an animated image with GIF data. After created, you can access
    /// the images via property '.images'. If the data is not animated gif, this
    /// function is same as UIImage(data: data, scale: scale)
    ///
    /// - Parameters:
    ///   - data: GIF data.
    ///   - scale: The scale factor
    /// - Returns: A new image created from GIF, or nil when an error occurs.
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
        var array: [UIImage] = []
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
            if alphaInfo == .premultipliedLast
                || alphaInfo == .premultipliedFirst
                || alphaInfo == .last
                || alphaInfo == .first {
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
    
    /// YYSwift: Whether the data is animated GIF.
    ///
    /// - Parameter data: Image data
    /// - Returns: Returns true only if the data is gif and contains more than one frame, otherwise returns false.
    public class func isAnimated(withGIFData data: Data) -> Bool {
        if data.count < 16 {
            return false
        }
        guard let source: CGImageSource = CGImageSourceCreateWithData(data as CFData, nil), CGImageSourceGetCount(source) > 1 else {
            return false
        }
        return true
    }
    
    /// YYSwift: Create an image from a PDF file data or path.
    ///
    /// - Parameter dataOrPath: PDF data in `Data`, or PDF file path in `String`.
    /// - Returns: A new image create from PDF, or nil when an error occurs.
    public class func image(withPDF dataOrPath: Any) -> UIImage? {
        return image(withPDF: dataOrPath, resize: false, size: CGSize.zero)
    }
    
    /// YYSwift: Create an image from a PDF file data or path.
    ///
    /// - Parameters:
    ///   - dataOrPath: PDF data in `Data`, or PDF file path in `String`.
    ///   - size: The new image's size, PDF's content will be stretched as needed.
    /// - Returns: A new image create from PDF, or nil when an error occurs.
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
    
    /// YYSwift: Create a square image from apple emoji.
    ///
    /// - Parameters:
    ///   - emoji: single emoji, such as "😄".
    ///   - size: image's size.
    /// - Returns: Image from emoji, or nil when an error occurs.
    public class func image(withEmoji emoji: String, size: CGFloat) -> UIImage? {
        if emoji.count == 0 || size < 1 {
            return nil
        }
        let scale = UIScreen.main.scale
        let font = CTFontCreateWithName("AppleColorEmoji" as CFString, size * scale, nil)
        let str = NSAttributedString(string: emoji, attributes: [kCTFontAttributeName as NSAttributedString.Key: font, kCTForegroundColorAttributeName as NSAttributedString.Key: UIColor.white.cgColor])
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
    
    /// YYSwift: Create and return a custom size image with the given color.
    /// Default size is 1x1
    ///
    /// - Parameters:
    ///   - color: The color.
    ///   - size: The image size.
    /// - Returns: New image from color.
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
    
    /// YYSwift: Create UIImage from color and size.
    ///
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    public convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        
        self.init(cgImage: aCgImage)
    }
    
    /// YYSwift: Create and return an image with custom draw code.
    ///
    /// - Parameters:
    ///   - size: The image size.
    ///   - drawBlock: The draw block.
    /// - Returns: The new image
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
    
    /// YYSwift: Draws the entire image in the specified rectangle, content changed with
    /// the contentMode.
    ///
    /// - Parameters:
    ///   - rect: The rectangle in which to draw the image.
    ///   - contentMode: Draw content mode
    ///   - clipsToBounds: A Boolean value that determines whether content are confined to the rect.
    public func draw(inRect rect: CGRect, contentMode: UIView.ContentMode, clipsToBounds: Bool) {
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
    
    /// YYSwift: Returns a new image which is scaled from this image.
    /// The image will be stretched as needed.
    ///
    /// - Parameter size: The new size to be scaled, values should be positive.
    /// - Returns: The new image with the given size.
    public func resized(to size: CGSize) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// YYSwift: Returns a new image which is scaled from this image.
    /// The image content will be changed with thencontentMode.
    ///
    /// - Parameters:
    ///   - size: The new size to be scaled, values should be positive.
    ///   - contentMode: The content mode for image content.
    /// - Returns: The new image with the given size.
    public func resized(to size: CGSize, contentMode: UIView.ContentMode) -> UIImage? {
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

fileprivate func uiImage(with cgImage: CGImage, scale: CGFloat, orientation: UIImage.Orientation) -> UIImage? {
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
#endif
