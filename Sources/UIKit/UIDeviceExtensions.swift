//
//  UIDeviceExtensions.swift
//  testNotification
//
//  Created by Phoenix on 2017/12/19.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    public static func systemVersion() -> Double {
        return Double(UIDevice.current.systemVersion)!
    }
    
    public var isPad: Bool {
        return UI_USER_INTERFACE_IDIOM() == .pad
    }
    
    public var isSimulator: Bool {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }
    
    public var isJailbroken: Bool {
        if self.isSimulator {
            return false
        }
        
        let paths = [
            "/Applications/Cydia.app",
            "/private/var/lib/apt/",
            "/private/var/lib/cydia",
            "/private/var/stash"
        ]
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        
        let bash = fopen("/bin/bash", "r")
        if bash != nil {
            fclose(bash)
            return true
        }
        
        let path = "/private/" + String.uuid()
        do {
            try "test".write(toFile: path, atomically: true, encoding: .utf8)
            try? FileManager.default.removeItem(atPath: path)
            return true
        } catch _ {
            
        }
        
        return false
    }
    
    public var canMakePhoneCalls: Bool {
        return UIApplication.shared.canOpenURL(URL(string: "tel://")!)
    }
    
    // https://stackoverflow.com/questions/30748480/swift-get-devices-ip-address/30748582
    private func ipAddress(withIfaName ifaName: String) -> String? {
        if ifaName.count == 0 { return nil }
        var address : String?
        
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                let name = String(cString: interface.ifa_name)
                if  name == ifaName {
                    
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
    
    public var ipAddressWIFI: String? {
        return self.ipAddress(withIfaName: "en0")
    }
    
    public var ipAddressCell: String? {
        return self.ipAddress(withIfaName: "pdp_ip0")
    }
    
    public var machineModel: String? {
        var machineSwiftString: String?
        var size: size_t = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        machineSwiftString = String(cString: machine, encoding: .utf8)
        return machineSwiftString
    }
    
    public var machineModelName: String? {
        guard let model = self.machineModel else { return nil }
        let dic = [
            "Watch1,1" : "Apple Watch 38mm",
            "Watch1,2" : "Apple Watch 42mm",
            "Watch2,3" : "Apple Watch Series 2 38mm",
            "Watch2,4" : "Apple Watch Series 2 42mm",
            "Watch2,6" : "Apple Watch Series 1 38mm",
            "Watch2,7" : "Apple Watch Series 1 42mm",
            "Watch3,1" : "Apple Watch Series 3 38mm",
            "Watch3,2" : "Apple Watch Series 3 42mm",
            "Watch3,3" : "Apple Watch Series 3 38mm",
            "Watch3,4" : "Apple Watch Series 3 42mm",
            
            "iPod1,1" : "iPod touch 1",
            "iPod2,1" : "iPod touch 2",
            "iPod3,1" : "iPod touch 3",
            "iPod4,1" : "iPod touch 4",
            "iPod5,1" : "iPod touch 5",
            "iPod7,1" : "iPod touch 6",
            
            "iPhone1,1" : "iPhone 1G",
            "iPhone1,2" : "iPhone 3G",
            "iPhone2,1" : "iPhone 3GS",
            "iPhone3,1" : "iPhone 4 (GSM)",
            "iPhone3,2" : "iPhone 4",
            "iPhone3,3" : "iPhone 4 (CDMA)",
            "iPhone4,1" : "iPhone 4S",
            "iPhone5,1" : "iPhone 5",
            "iPhone5,2" : "iPhone 5",
            "iPhone5,3" : "iPhone 5c",
            "iPhone5,4" : "iPhone 5c",
            "iPhone6,1" : "iPhone 5s",
            "iPhone6,2" : "iPhone 5s",
            "iPhone7,1" : "iPhone 6 Plus",
            "iPhone7,2" : "iPhone 6",
            "iPhone8,1" : "iPhone 6s",
            "iPhone8,2" : "iPhone 6s Plus",
            "iPhone8,4" : "iPhone SE",
            "iPhone9,1" : "iPhone 7",
            "iPhone9,2" : "iPhone 7 Plus",
            "iPhone9,3" : "iPhone 7",
            "iPhone9,4" : "iPhone 7 Plus",
            "iPhone10,1" : "iPhone 8",
            "iPhone10,4" : "iPhone 8",
            "iPhone10,2" : "iPhone 8 Plus",
            "iPhone10,5" : "iPhone 8 Plus",
            "iPhone10,3" : "iPhone X",
            "iPhone10,6" : "iPhone X",
            
            "iPad1,1" : "iPad 1",
            "iPad2,1" : "iPad 2 (WiFi)",
            "iPad2,2" : "iPad 2 (GSM)",
            "iPad2,3" : "iPad 2 (CDMA)",
            "iPad2,4" : "iPad 2",
            "iPad2,5" : "iPad mini 1",
            "iPad2,6" : "iPad mini 1",
            "iPad2,7" : "iPad mini 1",
            "iPad3,1" : "iPad 3 (WiFi)",
            "iPad3,2" : "iPad 3 (4G)",
            "iPad3,3" : "iPad 3 (4G)",
            "iPad3,4" : "iPad 4",
            "iPad3,5" : "iPad 4",
            "iPad3,6" : "iPad 4",
            "iPad4,1" : "iPad Air",
            "iPad4,2" : "iPad Air",
            "iPad4,3" : "iPad Air",
            "iPad4,4" : "iPad mini 2",
            "iPad4,5" : "iPad mini 2",
            "iPad4,6" : "iPad mini 2",
            "iPad4,7" : "iPad mini 3",
            "iPad4,8" : "iPad mini 3",
            "iPad4,9" : "iPad mini 3",
            "iPad5,1" : "iPad mini 4",
            "iPad5,2" : "iPad mini 4",
            "iPad5,3" : "iPad Air 2",
            "iPad5,4" : "iPad Air 2",
            "iPad6,3" : "iPad Pro (9.7 inch)",
            "iPad6,4" : "iPad Pro (9.7 inch)",
            "iPad6,7" : "iPad Pro (12.9 inch)",
            "iPad6,8" : "iPad Pro (12.9 inch)",
            "iPad6,11" : "iPad 5",
            "iPad6,12" : "iPad 5",
            "iPad7,1" : "iPad Pro 2 (12.9 inch)",
            "iPad7,2" : "iPad Pro 2 (12.9 inch)",
            "iPad7,3" : "iPad Pro (10.5 inch)",
            "iPad7,4" : "iPad Pro (10.5 inch)",
            
            "AppleTV2,1" : "Apple TV 2",
            "AppleTV3,1" : "Apple TV 3",
            "AppleTV3,2" : "Apple TV 3",
            "AppleTV5,3" : "Apple TV 4",
            "AppleTV6,2" : "Apple TV 4K",
            
            "i386" : "Simulator x86",
            "x86_64" : "Simulator x64",
        ]
        if let name = dic[model] {
            return name
        }
        return nil
    }
    
    public var systemUptime: Date {
        let interval = ProcessInfo.processInfo.systemUptime
        return Date(timeIntervalSinceNow: interval)
    }
    
    public var diskSpace: Int64 {
        do {
            let attrs = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            var space = attrs[.systemSize] as! Int64
            if space < 0 {
                space = -1
            }
            return space
        } catch _ {
            return -1
        }
    }
    
    public var diskSpaceFree: Int64 {
        do {
            let attrs = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            var space = attrs[.systemFreeSize] as! Int64
            if space < 0 {
                space = -1
            }
            return space
        } catch _ {
            return -1
        }
    }
    
    public var diskSpaceUsed: Int64 {
        let total = self.diskSpace
        let free = self.diskSpaceFree
        if total < 0 || free < 0 {
            return -1
        }
        var used = total - free
        if used < 0 {
            used = -1
        }
        return used
    }
    
    public var memoryTotal: Int64 {
        let mem = ProcessInfo.processInfo.physicalMemory
        guard mem > 0 else { return -1 }
        return Int64(mem)
    }
    
    //https://github.com/zixun/SystemEye/blob/master/SystemEye/Classes/Memory.swift
    public var appMemoryUsage: (used: Int64, total: Int64) {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout.size(ofValue: info) / MemoryLayout<integer_t>.size)
        let kerr = withUnsafeMutablePointer(to: &info) {
            return $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                return task_info(mach_task_self_,task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        guard kerr == KERN_SUCCESS else {
            return (0, self.memoryTotal)
        }
        
        return (Int64(info.resident_size), self.memoryTotal)
    }

    public var systemMemoryUsage: (free: Int64,
                                   active: Int64,
                                   inactive: Int64,
                                   wired: Int64,
                                   compressed: Int64,
                                   purgable: Int64,
                                   total: Int64) {
        var statistics: vm_statistics64 {
            var size     = HOST_VM_INFO64_COUNT
            var hostInfo = vm_statistics64()
            let result = withUnsafeMutablePointer(to: &hostInfo) {
                $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
                    host_statistics64(mach_host_self(), HOST_VM_INFO64, $0, &size)
                }
            }
            #if DEBUG
                if result != KERN_SUCCESS {
                    print("ERROR - \(#file):\(#function) - kern_result_t = "
                        + "\(result)")
                }
            #endif
            return hostInfo
        }
        
        
        let free = Double(statistics.free_count) * PAGE_SIZE
        let active = Double(statistics.active_count) * PAGE_SIZE
        let inactive = Double(statistics.inactive_count) * PAGE_SIZE
        let wired = Double(statistics.wire_count) * PAGE_SIZE
        let compressed = Double(statistics.compressor_page_count) * PAGE_SIZE
        let purgable = Double(statistics.purgeable_count) * PAGE_SIZE
        print(PAGE_SIZE)
        return (
            Int64(free),
            Int64(active),
            Int64(inactive),
            Int64(wired),
            Int64(compressed),
            Int64(purgable),
            self.memoryTotal
        )
    }
    
    
    
    public var systemCPUUsage: (system: Double,
                             user: Double,
                             idle: Double,
                             nice: Double) {
            let load = UIDevice.hostCPULoadInfo
            
        let userDiff = Double(load.cpu_ticks.0 - UIDevice.loadPrevious.cpu_ticks.0)
        let sysDiff  = Double(load.cpu_ticks.1 - UIDevice.loadPrevious.cpu_ticks.1)
        let idleDiff = Double(load.cpu_ticks.2 - UIDevice.loadPrevious.cpu_ticks.2)
        let niceDiff = Double(load.cpu_ticks.3 - UIDevice.loadPrevious.cpu_ticks.3)
            
            let totalTicks = sysDiff + userDiff + niceDiff + idleDiff
            
            let sys  = sysDiff  / totalTicks * 100.0
            let user = userDiff / totalTicks * 100.0
            let idle = idleDiff / totalTicks * 100.0
            let nice = niceDiff / totalTicks * 100.0
            
        UIDevice.loadPrevious = load
            
            return (sys, user, idle, nice)
    }
    
    public var appCPUUsage: Double {
        let threads = UIDevice.threadBasicInfos()
        var result : Double = 0.0
        threads.forEach { (thread:thread_basic_info) in
            if UIDevice.flag(thread) {
                result += Double.init(thread.cpu_usage) / Double.init(TH_USAGE_SCALE);
            }
        }
        return result * 100
    }
    
    private static var loadPrevious = host_cpu_load_info()
    
    static var hostCPULoadInfo: host_cpu_load_info {
        get {
            var size     = HOST_CPU_LOAD_INFO_COUNT
            var hostInfo = host_cpu_load_info()
            let result = withUnsafeMutablePointer(to: &hostInfo) {
                $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
                    host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, $0, &size)
                }
            }
            
            #if DEBUG
                if result != KERN_SUCCESS {
                    fatalError("ERROR - \(#file):\(#function) - kern_result_t = "
                        + "\(result)")
                }
            #endif
            
            return hostInfo
        }
    }
    
    private class func flag(_ thread:thread_basic_info) -> Bool {
        let foo = thread.flags & TH_FLAGS_IDLE
        let number = NSNumber.init(value: foo)
        return !Bool.init(truncating: number)
    }
    
    private class func threadBasicInfos() -> [thread_basic_info]  {
        var result = [thread_basic_info]()
        
        var thinfo : thread_info_t = thread_info_t.allocate(capacity: Int(THREAD_INFO_MAX))
        let thread_info_count = UnsafeMutablePointer<mach_msg_type_number_t>.allocate(capacity: 128)
        let count: Int = MemoryLayout<thread_basic_info_data_t>.size / MemoryLayout<integer_t>.size
        for act_t in threadActPointers() {
            thread_info_count.pointee = UInt32(THREAD_INFO_MAX);
            let kr = thread_info(act_t ,thread_flavor_t(THREAD_BASIC_INFO),thinfo, thread_info_count);
            if (kr != KERN_SUCCESS) {
                return [thread_basic_info]();
            }
            
            let th_basic_info = withUnsafePointer(to: &thinfo, {
                return $0.withMemoryRebound(to: thread_basic_info_t.self, capacity: count, {
                    return $0.pointee
                })
            }).pointee

            result.append(th_basic_info)
            
        }
        
        return result
    }
    
    private class func threadActPointers() -> [thread_act_t] {
        var threads_act = [thread_act_t]()
        
        var threads_array: thread_act_array_t? = nil
        var count = mach_msg_type_number_t()
        
        let result = task_threads(mach_task_self_, &(threads_array), &count)
        
        guard result == KERN_SUCCESS else {
            return threads_act
        }
        
        guard let array = threads_array  else {
            return threads_act
        }
        
        for i in 0..<count {
            threads_act.append(array[Int(i)])
        }
        
        let krsize = count * UInt32.init(MemoryLayout<thread_t>.size)
        _ = vm_deallocate(mach_task_self_, vm_address_t(array.pointee), vm_size_t(krsize));
        return threads_act
    }
}

private let HOST_VM_INFO64_COUNT: mach_msg_type_number_t =
    UInt32(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size)

private let PAGE_SIZE: Double = Double(vm_kernel_page_size)

private let HOST_CPU_LOAD_INFO_COUNT: mach_msg_type_number_t =
    UInt32(MemoryLayout<host_cpu_load_info_data_t>.size / MemoryLayout<integer_t>.size)
