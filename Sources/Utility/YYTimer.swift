//
//  YYTimer.swift
//  testNotification
//
//  Created by Phoenix on 2017/12/15.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public class YYTimer {
    
    fileprivate let timer: DispatchSourceTimer
    
    public private(set) var repeats: Bool
    
    public private(set) var timeInterval: TimeInterval
    
    public private(set) var isValid: Bool
    
    public typealias YYTimerHandler = (YYTimer) -> Void
    
    private var handler: YYTimerHandler
    
    public init(fireTime start: TimeInterval = 0, interval: TimeInterval, repeats: Bool = true, queue: DispatchQueue = .main, handler: @escaping YYTimerHandler) {
        
        self.repeats = repeats
        self.handler = handler
        self.timeInterval = interval
        self.isValid = true
        
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer.setEventHandler { [weak self] in
            if let strongSelf = self {
                handler(strongSelf)
            }
        }
        let deadlineTime: DispatchTimeInterval = .milliseconds(Int(start * 1000))
        let timeInterval: DispatchTimeInterval = .milliseconds(Int(interval * 1000))
        if repeats {
            timer.schedule(deadline: .now() + deadlineTime,
                           repeating: timeInterval)
        }
        else {
            timer.schedule(deadline: .now() + deadlineTime)
        }
        timer.resume()
    }
    
    deinit {
        if !isValid {
            timer.resume()
        }
    }
    
    public static func repeats(after fireTime: TimeInterval = 0,
                               withInterval interval: TimeInterval,
                               queue: DispatchQueue = .main,
                               handler: @escaping YYTimerHandler) -> YYTimer {
        
        return YYTimer(fireTime: fireTime,
                       interval: interval,
                       repeats: true,
                       queue: queue,
                       handler: handler)
    }
    
    public static func countDown(interval: TimeInterval, times: Int, queue: DispatchQueue = .main , handler: @escaping (YYCountDownTimer, _ leftTimes: Int) -> Void) -> YYCountDownTimer {
        let countDownTimer =  YYCountDownTimer(interval: interval, times: times, queue: queue, handler: handler)
        countDownTimer.start()
        return countDownTimer
    }
    
    public static func after(_ fireTime: TimeInterval,
                             queue: DispatchQueue = .main,
                             handler: @escaping () -> Void) {
        queue.asyncAfter(deadline: .now() + fireTime) {
            handler()
        }
    }
    

    public func fire() {
     
        if repeats {
            if !isValid {
                timer.resume()
                isValid = true
            }
        }
        else {
            handler(self)
            invalidate()
        }
    }
    
    public func suspend() {
        if isValid {
            timer.suspend()
            isValid = false
        }
    }
    
    public func invalidate() {
        timer.cancel()
        isValid = false
    }
}

public class YYCountDownTimer {
    
    private let timer: YYTimer
    
    private var leftTimes: Int
    
    private let originalTimes: Int
    
    private let handler: (YYCountDownTimer, _ leftTimes: Int) -> Void
    
    public init(interval: TimeInterval, times: Int, queue: DispatchQueue = .main , handler: @escaping (YYCountDownTimer, _ leftTimes: Int) -> Void) {
        
        self.leftTimes = times
        self.originalTimes = times
        self.handler = handler
        self.timer = YYTimer.repeats(after: 0, withInterval: interval, queue: queue, handler: { _ in })
        self.timer.timer.setEventHandler { [weak self] in
            if let strongSelf = self {
                if strongSelf.leftTimes > 0 {
                    strongSelf.leftTimes = strongSelf.leftTimes - 1
                    strongSelf.handler(strongSelf, strongSelf.leftTimes)
                }
                else {
                    strongSelf.timer.suspend()
                }
            }
        }
    }
    
    public func start() {
        self.timer.fire()
    }
    
    public func suspend() {
        self.timer.suspend()
    }
    
    public func reCountDown() {
        self.leftTimes = self.originalTimes
    }

}
