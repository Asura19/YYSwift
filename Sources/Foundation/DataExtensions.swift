//
//  DataExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/10/30.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation
#if os(iOS) || os(macOS)
import CommonCrypto
import Swiftzlib
#endif


#if os(iOS) || os(macOS)
// MARK: - Hash
public extension Data {
    
    public var md2Data: Data? {
        var result = Data(count: Int(CC_MD2_DIGEST_LENGTH))
        _ = result.withUnsafeMutableBytes { digestBytes in
            self.withUnsafeBytes { messageBytes in
                CC_MD2(messageBytes, CC_LONG(self.count), digestBytes)
            }
        }
        return result
    }
    
    public var md2String: String? {
        return md2Data?.reduce("") {
            $0 + String(format:"%02x", $1)
        }
    }
    
    public var md4Data: Data? {
        var result = Data(count: Int(CC_MD4_DIGEST_LENGTH))
        _ = result.withUnsafeMutableBytes { digestBytes in
            self.withUnsafeBytes { messageBytes in
                CC_MD4(messageBytes, CC_LONG(self.count), digestBytes)
            }
        }
        return result
    }
    
    public var md4String: String? {
        return md4Data?.reduce("") {
            $0 + String(format:"%02x", $1)
        }
    }
    
    public var md5Data: Data? {
        var result = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        _ = result.withUnsafeMutableBytes { digestBytes in
            self.withUnsafeBytes { messageBytes in
                CC_MD5(messageBytes, CC_LONG(self.count), digestBytes)
            }
        }
        return result
    }
    
    public var md5String: String? {
        return md5Data?.reduce("") {
            $0 + String(format:"%02x", $1)
        }
    }
    
    public var sha1Data: Data? {
        var result = Data(count: Int(CC_SHA1_DIGEST_LENGTH))
        _ = result.withUnsafeMutableBytes { digestBytes in
            self.withUnsafeBytes { messageBytes in
                CC_SHA1(messageBytes, CC_LONG(self.count), digestBytes)
            }
        }
        return result
    }

    public var sha1String: String? {
        return sha1Data?.reduce("") {
            $0 + String(format:"%02x", $1)
        }
    }
    
    public var sha224Data: Data? {
        var result = Data(count: Int(CC_SHA224_DIGEST_LENGTH))
        _ = result.withUnsafeMutableBytes { digestBytes in
            self.withUnsafeBytes { messageBytes in
                CC_SHA224(messageBytes, CC_LONG(self.count), digestBytes)
            }
        }
        return result
    }
    
    public var sha224String: String? {
        return sha224Data?.reduce("") {
            $0 + String(format:"%02x", $1)
        }
    }
    
    public var sha256Data: Data? {
        var result = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = result.withUnsafeMutableBytes { digestBytes in
            self.withUnsafeBytes { messageBytes in
                CC_SHA256(messageBytes, CC_LONG(self.count), digestBytes)
            }
        }
        return result
    }
    
    public var sha256String: String? {
        return sha256Data?.reduce("") {
            $0 + String(format:"%02x", $1)
        }
    }
    
    public var sha384Data: Data? {
        var result = Data(count: Int(CC_SHA384_DIGEST_LENGTH))
        _ = result.withUnsafeMutableBytes { digestBytes in
            self.withUnsafeBytes { messageBytes in
                CC_SHA384(messageBytes, CC_LONG(self.count), digestBytes)
            }
        }
        return result
    }
    
    public var sha384String: String? {
        return sha384Data?.reduce("") {
            $0 + String(format:"%02x", $1)
        }
    }
    
    public var sha512Data: Data? {
        var result = Data(count: Int(CC_SHA512_DIGEST_LENGTH))
        _ = result.withUnsafeMutableBytes { digestBytes in
            self.withUnsafeBytes { messageBytes in
                CC_SHA512(messageBytes, CC_LONG(self.count), digestBytes)
            }
        }
        return result
    }
    
    public var sha512String: String? {
        return sha512Data?.reduce("") {
            $0 + String(format:"%02x", $1)
        }
    }
    
    private func hmac(UsingAlgorithm alg: HmacAlgorithm, withKey key: String) -> String? {
        var result = Data(count: alg.digestLenght)
        let cKey = key.cString(using: .utf8)
        let keyLength = key.lengthOfBytes(using: .utf8)
        _ = result.withUnsafeMutableBytes { digestBytes in
            self.withUnsafeBytes { messageBytes in
                CCHmac(alg.ccHmacAlgorithm, cKey!, keyLength, messageBytes, self.count, digestBytes)
            }
        }
        return result.reduce("") {
            $0 + String(format:"%02x", $1)
        }
    }
    
    private func hmac(UsingAlgorithm alg: HmacAlgorithm, withKey key: Data) -> Data? {
        let keyString = String.init(data: key, encoding: .utf8)
        var result = Data(count: alg.digestLenght)
        let cKey = keyString?.cString(using: .utf8)
        let keyLength = keyString?.lengthOfBytes(using: .utf8)
        _ = result.withUnsafeMutableBytes { digestBytes in
            self.withUnsafeBytes { messageBytes in
                CCHmac(alg.ccHmacAlgorithm, cKey!, keyLength!, messageBytes, self.count, digestBytes)
            }
        }
        return result
    }
    
    private enum HmacAlgorithm {
        case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
        
        var digestLenght: Int {
            var result: Int32 = 0
            switch self {
            case .MD5:      result = CC_MD5_DIGEST_LENGTH
            case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
            case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
            case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
            case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
            case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
            }
            return Int(result)
        }
        
        var ccHmacAlgorithm: CCHmacAlgorithm {
            var result: Int = 0
            switch self {
            case .MD5:      result = kCCHmacAlgMD5
            case .SHA1:     result = kCCHmacAlgSHA1
            case .SHA224:   result = kCCHmacAlgSHA224
            case .SHA256:   result = kCCHmacAlgSHA256
            case .SHA384:   result = kCCHmacAlgSHA384
            case .SHA512:   result = kCCHmacAlgSHA512
            }
            return CCHmacAlgorithm(result)
        }
    }
    
    public func hmacMD5String(withKey key: String) -> String? {
        return hmac(UsingAlgorithm: .MD5, withKey: key)
    }
    
    public func hmacMD5Data(withKey key: Data) -> Data? {
        return hmac(UsingAlgorithm: .MD5, withKey: key)
    }
    
    public func hmacSHA1String(withKey key: String) -> String? {
        return hmac(UsingAlgorithm: .SHA1, withKey: key)
    }
    
    public func hmacSHA1Data(withKey key: Data) -> Data? {
        return hmac(UsingAlgorithm: .SHA1, withKey: key)
    }
    
    public func hmacSHA224String(withKey key: String) -> String? {
        return hmac(UsingAlgorithm: .SHA224, withKey: key)
    }
    
    public func hmacSHA224Data(withKey key: Data) -> Data? {
        return hmac(UsingAlgorithm: .SHA224, withKey: key)
    }
    
    public func hmacSHA256String(withKey key: String) -> String? {
        return hmac(UsingAlgorithm: .SHA256, withKey: key)
    }
    
    public func hmacSHA256Data(withKey key: Data) -> Data? {
        return hmac(UsingAlgorithm: .SHA256, withKey: key)
    }
    
    public func hmacSHA384String(withKey key: String) -> String? {
        return hmac(UsingAlgorithm: .SHA384, withKey: key)
    }
    
    public func hmacSHA384Data(withKey key: Data) -> Data? {
        return hmac(UsingAlgorithm: .SHA384, withKey: key)
    }
    
    public func hmacSHA512String(withKey key: String) -> String? {
        return hmac(UsingAlgorithm: .SHA384, withKey: key)
    }
    
    public func hmacSHA512Data(withKey key: Data) -> Data? {
        return hmac(UsingAlgorithm: .SHA384, withKey: key)
    }
    
}


// MARK: - Encrypt
public extension Data  {
    //    public func crc32() -> UInt32 {
    //        let crc = self.withUnsafeBytes {
    //            crc32(0, $0, numericCast(self.count))
    //        }
    //    }
    
    public func aes256Encrypt(withKey key: Data, iv: Data) -> Data? {
        guard key.count == 16 || key.count == 24 || key.count == 32 else { return nil }
        guard iv.count == 16 || iv.count == 0 else { return nil }
        
        let cryptLength  = Int(self.count + kCCBlockSizeAES128)
        var result = Data(count:cryptLength)
        let keyLength = size_t(kCCKeySizeAES128)
        var encryptedSize: size_t = 0
        
        let cryptStatus = result.withUnsafeMutableBytes { cryptBytes in
            self.withUnsafeBytes { dataBytes in
                iv.withUnsafeBytes { ivBytes in
                    key.withUnsafeBytes { keyBytes in
                        CCCrypt(CCOperation(kCCEncrypt),
                                CCAlgorithm(kCCAlgorithmAES128),
                                CCOptions(kCCOptionPKCS7Padding),
                                keyBytes,
                                keyLength,
                                ivBytes,
                                dataBytes,
                                self.count,
                                cryptBytes,
                                cryptLength,
                                &encryptedSize)
                    }
                }
            }
        }
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            result.removeSubrange(encryptedSize..<result.count)
            return result;
        }
        else {
            print("Error: \(cryptStatus)")
            return nil
        }
    }
    
    public func aes256Decrypt(withKey key: Data, iv: Data) -> Data? {
        guard key.count == 16 || key.count == 24 || key.count == 32 else { return nil }
        guard iv.count == 16 || iv.count == 0 else { return nil }
        
        let cryptLength  = Int(self.count + kCCBlockSizeAES128)
        var result = Data(count:cryptLength)
        let keyLength = size_t(kCCKeySizeAES128)
        var encryptedSize: size_t = 0
        
        let cryptStatus = result.withUnsafeMutableBytes { cryptBytes in
            self.withUnsafeBytes { dataBytes in
                iv.withUnsafeBytes { ivBytes in
                    key.withUnsafeBytes { keyBytes in
                        CCCrypt(CCOperation(kCCDecrypt),
                                CCAlgorithm(kCCAlgorithmAES128),
                                CCOptions(kCCOptionPKCS7Padding),
                                keyBytes,
                                keyLength,
                                ivBytes,
                                dataBytes,
                                self.count,
                                cryptBytes,
                                cryptLength,
                                &encryptedSize)
                    }
                }
            }
        }
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            result.removeSubrange(encryptedSize..<result.count)
            return result;
        }
        else {
            print("Error: \(cryptStatus)")
            return nil
        }
    }
    /*
        public func aes256Encrypt(withKey key: Data, iv: Data) -> Data? {
            let cryptor: CCCryptorRef?
            var status: CCCryptorStatus = CCCryptorStatus(kCCSuccess)
            var buffer = Data()
    
            cryptor = key.withUnsafeBytes { (keyPtr: UnsafePointer<UInt8>) in
                iv.withUnsafeBytes { (ivPtr: UnsafePointer<UInt8>) in
                    var cryptorOut: CCCryptorRef?
                    let statusResult =  CCCryptorCreate(
                        CCOperation(kCCEncrypt),
                        CCAlgorithm(kCCAlgorithmAES128),
                        CCOptions(kCCOptionPKCS7Padding),
                        keyPtr,
                        key.count,
                        ivPtr,
                        &cryptorOut
                    )
                    assert(statusResult == CCCryptorStatus(kCCSuccess))
                    return cryptorOut
                }
            }
    
            let bufferSize = CCCryptorGetOutputLength(cryptor, self.count, true)
            buffer.count = bufferSize
    
            var dataOutMoved = 0
            status = self.withUnsafeBytes { dataPtr in
                buffer.withUnsafeMutableBytes { bufferPtr in
                    return CCCryptorUpdate(
                        cryptor,
                        dataPtr, self.count,
                        bufferPtr, bufferSize,
                        &dataOutMoved)
                }
            }
            assert(status == CCCryptorStatus(kCCSuccess))
            buffer.count = dataOutMoved
    
            let outputLength = CCCryptorGetOutputLength(cryptor, 0, true)
            status = buffer.withUnsafeMutableBytes { bufferPtr in
                CCCryptorFinal(
                    cryptor,
                    bufferPtr,
                    outputLength,
                    &dataOutMoved
                )
            }
            assert(status == CCCryptorStatus(kCCSuccess))
            buffer.count = dataOutMoved
            defer { buffer = Data() }
            return buffer
        }
     */
}

#endif

// MARK: - Initializer
public extension Data {
    
    init?(hexString: String) {
        self = Data(capacity: hexString.count / 2)
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: hexString, options: .reportProgress, range: NSMakeRange(0, hexString.utf16.count)) { match, flags, stop in
            let byteString = hexString[(match?.range.lowerBound)!..<(match?.range.upperBound)!]
            var num = UInt8(byteString!, radix: 16)!
            self.append(&num, count: 1)
        }
        guard self.count > 0 else { return nil }
        return
    }
    
    init?(dataName name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "") else {
            return nil
        }
        self = try! Data.init(contentsOf: url)
        return
    }
}


public extension Data {
    
    public var utf8String: String? {
        if self.count > 0 {
            return String(data: self, encoding: .utf8)
        }
        return nil
    }
    
    public var hexString: String? {
        return self.reduce("") {
            $0 + String(format:"%02x", $1)
        }
    }
    
    public func jsonValueDecoded() -> Any? {
        return try? JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions())
    }
   
}


#if os(iOS) || os(macOS)
public extension Data {

    private func createZStream() -> z_stream {
        
        var stream = z_stream()
        
        self.withUnsafeBytes { (bytes: UnsafePointer<Bytef>) in
            stream.next_in = UnsafeMutablePointer<Bytef>(mutating: bytes)
        }
        stream.avail_in = uint(self.count)
        
        return stream
    }
    
    private struct DataSize {
        
        static let chunk = Int(pow(2.0, 14))
        static let stream = MemoryLayout<z_stream>.size
        
        private init() { }
    }
    
    public func gzipInflate() -> Data {
        guard !self.isEmpty else {
            return Data()
        }
        
        let contiguousData = self.withUnsafeBytes { Data(bytes: $0, count: self.count) }
        var stream = contiguousData.createZStream()
        var status: Int32
        
        status = inflateInit2_(&stream, MAX_WBITS + 32, ZLIB_VERSION, Int32(DataSize.stream))
        
        guard status == Z_OK else {
            return Data()
        }
        
        var data = Data(capacity: contiguousData.count * 2)
        
        repeat {
            if Int(stream.total_out) >= data.count {
                data.count += contiguousData.count / 2
            }
            
            data.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<Bytef>) in
                stream.next_out = bytes.advanced(by: Int(stream.total_out))
            }
            stream.avail_out = uInt(data.count) - uInt(stream.total_out)
            
            status = inflate(&stream, Z_SYNC_FLUSH)
            
        } while status == Z_OK
        
        guard inflateEnd(&stream) == Z_OK && status == Z_STREAM_END else {
            
            return Data()
        }
        
        data.count = Int(stream.total_out)
        
        return data
    }
    
    public func gzipDeflate() -> Data {
        guard !self.isEmpty else {
            return Data()
        }
        
        let contiguousData = self.withUnsafeBytes { Data(bytes: $0, count: self.count) }
        var stream = contiguousData.createZStream()
        var status: Int32
        
        status = deflateInit2_(&stream, Z_NO_COMPRESSION, Z_DEFLATED, MAX_WBITS + 16, MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY, ZLIB_VERSION, Int32(DataSize.stream))
        
        guard status == Z_OK else {
            return Data()
        }
        
        var data = Data(capacity: DataSize.chunk)
        while stream.avail_out == 0 {
            if Int(stream.total_out) >= data.count {
                data.count += DataSize.chunk
            }
            
            data.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<Bytef>) in
                stream.next_out = bytes.advanced(by: Int(stream.total_out))
            }
            stream.avail_out = uInt(data.count) - uInt(stream.total_out)
            
            deflate(&stream, Z_FINISH)
        }
        
        deflateEnd(&stream)
        data.count = Int(stream.total_out)
        
        return data
    }
    
    public func zlibInflate() -> Data {
        guard !self.isEmpty else {
            return Data()
        }
        
        let contiguousData = self.withUnsafeBytes { Data(bytes: $0, count: self.count) }
        var stream = contiguousData.createZStream()
        var status: Int32
        
        status = inflateInit_(&stream, ZLIB_VERSION, Int32(DataSize.stream))
        
        guard status == Z_OK else {
            return Data()
        }
        
        var data = Data(capacity: contiguousData.count * 2)
        
        repeat {
            if Int(stream.total_out) >= data.count {
                data.count += contiguousData.count / 2
            }
            
            data.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<Bytef>) in
                stream.next_out = bytes.advanced(by: Int(stream.total_out))
            }
            stream.avail_out = uInt(data.count) - uInt(stream.total_out)
            
            status = inflate(&stream, Z_SYNC_FLUSH)
            
        } while status == Z_OK
        
        guard inflateEnd(&stream) == Z_OK && status == Z_STREAM_END else {
            
            return Data()
        }
        
        data.count = Int(stream.total_out)
        
        return data
    }
    
    public func zlibDeflate() -> Data {
        guard !self.isEmpty else {
            return Data()
        }
        
        let contiguousData = self.withUnsafeBytes { Data(bytes: $0, count: self.count) }
        var stream = contiguousData.createZStream()
        var status: Int32
        
        status = deflateInit_(&stream, Z_NO_COMPRESSION, ZLIB_VERSION, Int32(DataSize.stream))
        
        guard status == Z_OK else {
            return Data()
        }
        
        var data = Data(capacity: DataSize.chunk)
        while stream.avail_out == 0 {
            if Int(stream.total_out) >= data.count {
                data.count += DataSize.chunk
            }
            
            data.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<Bytef>) in
                stream.next_out = bytes.advanced(by: Int(stream.total_out))
            }
            stream.avail_out = uInt(data.count) - uInt(stream.total_out)
            
            deflate(&stream, Z_FINISH)
        }
        
        deflateEnd(&stream)
        data.count = Int(stream.total_out)
        
        return data
    }
}
    
#endif