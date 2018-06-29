//
//  DateExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/8.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

#if canImport(Foundation)
import Foundation

public extension Date {
    
    /// YYSwift: Day name format.
    ///
    /// - threeLetters: 3 letter day abbreviation of day name.
    /// - full: Full day name.
    public enum DayNameStyle {
        case threeLetters
        case full
    }

    /// YYSwift: Month name format.
    ///
    /// - threeLetters: 3 letter month abbreviation of month name.
    /// - full: Full month name.
    public enum MonthNameStyle {
        case threeLetters
        case full
    }
    
}

public extension Date {
    
    /// YYSwift: User’s current calendar.
    public var calendar: Calendar {
        return Calendar.current
    }
    
    /// YYSwift: Era.
    ///
    ///     Date().era -> 1
    ///
    public var era: Int {
        return Calendar.current.component(.era, from: self)
    }
    
    /// YYSwift: Year.
    ///
    ///     Date().year -> 2017
    ///
    ///     var someDate = Date()
    ///     someDate.year = 2000 // sets someDate's year to 2000
    ///
    public var year: Int {
        get {
            return Calendar.current.component(.year, from: self)
        }
        set {
            guard newValue > 0 else {
                return
            }
            let currentYear = Calendar.current.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = Calendar.current.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// YYSwift: Quarter.
    ///
    ///     Date().quarter -> 3 // date in third quarter of the year.
    ///
    public var quarter: Int {
        let month = Double(Calendar.current.component(.month, from: self))
        let numberOfMonths = Double(Calendar.current.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 4
        return Int(ceil(month/numberOfMonthsInQuarter))
    }
    
    /// YYSwift: Month.
    ///
    ///     Date().month -> 1
    ///
    ///     var someDate = Date()
    ///     someDate.month = 10 // sets someDate's month to 10.
    ///
    public var month: Int {
        get {
            return Calendar.current.component(.month, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else {
                return
            }
            
            let currentMonth = Calendar.current.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = Calendar.current.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// YYSwift: Day.
    ///
    ///     Date().day -> 12
    ///
    ///     var someDate = Date()
    ///     someDate.day = 1 // sets someDate's day of month to 1.
    ///
    public var day: Int {
        get {
            return Calendar.current.component(.day, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else {
                return
            }
            
            let currentDay = Calendar.current.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = Calendar.current.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// YYSwift: Hour.
    ///
    ///     Date().hour -> 17 // 5 pm
    ///
    ///     var someDate = Date()
    ///     someDate.hour = 13 // sets someDate's hour to 1 pm.
    ///
    public var hour: Int {
        get {
            return Calendar.current.component(.hour, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(newValue) else {
                return
            }
            
            let currentHour = Calendar.current.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = Calendar.current.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// YYSwift: Minutes.
    ///
    ///     Date().minute -> 39
    ///
    ///     var someDate = Date()
    ///     someDate.minute = 10 // sets someDate's minutes to 10.
    ///
    public var minute: Int {
        get {
            return Calendar.current.component(.minute, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(newValue) else {
                return
            }
            
            let currentMinutes = Calendar.current.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = Calendar.current.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// YYSwift: Seconds.
    ///
    ///     Date().second -> 55
    ///
    ///     var someDate = Date()
    ///     someDate.second = 15 // sets someDate's seconds to 15.
    ///
    public var second: Int {
        get {
            return Calendar.current.component(.second, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(newValue) else {
                return
            }
            
            let currentSeconds = Calendar.current.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = Calendar.current.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// YYSwift: Nanoseconds.
    ///
    ///     Date().nanosecond -> 981379985
    ///
    ///     var someDate = Date()
    ///     someDate.nanosecond = 981379985 // sets someDate's seconds to 981379985.
    ///
    public var nanosecond: Int {
        get {
            return Calendar.current.component(.nanosecond, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(newValue) else {
                return
            }
            
            let currentNanoseconds = Calendar.current.component(.nanosecond, from: self)
            let nanosecondsToAdd = newValue - currentNanoseconds
            
            if let date = Calendar.current.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// YYSwift: Milliseconds.
    ///
    ///     Date().millisecond -> 68
    ///
    ///     var someDate = Date()
    ///     someDate.millisecond = 68 // sets someDate's nanosecond to 68000000.
    ///
    public var millisecond: Int {
        get {
            return Calendar.current.component(.nanosecond, from: self) / 1000000
        }
        set {
            let nanoSeconds = newValue * 1000000
            let allowedRange = Calendar.current.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(nanoSeconds) else { return }
            
            if let date = Calendar.current.date(bySetting: .nanosecond, value: nanoSeconds, of: self) {
                self = date
            }
        }
    }
    
    /// YYSwift: Weekday
    public var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    /// YYSwift: weekdayOrdinal.
    ///
    ///     If today is Friday
    ///     Date().weekdayOrdinal -> 2 // second Friday in the current month.
    ///
    public var weekdayOrdinal: Int {
        return Calendar.current.component(.weekdayOrdinal, from: self)
    }
    
    /// YYSwift: Week of month.
    ///
    ///     Date().weekOfMonth -> 3 // date is in third week of the month.
    ///
    public var weekOfMonth: Int {
        return Calendar.current.component(.weekOfMonth, from: self)
    }
    
    /// YYSwift: Week of year.
    ///
    ///     Date().weekOfYear -> 2 // second week in the year.
    ///
    public var weekOfYear: Int {
        return Calendar.current.component(.weekOfYear, from: self)
    }
    
    /// YYSwift: yearForWeekOfYear.
    /// https://developer.apple.com/documentation/foundation/nsdatecomponents/1413809-yearforweekofyear
    /// If the date is Jan 1, 2016, it is Friday, according to ISO 8601, the first week of the year contains Thursday is next week, so this week belongs to 2015, and "date.yearForWeekOfYear" is 2015
//    public var yearForWeekOfYear: Int {
//        return Calendar.current.component(.yearForWeekOfYear, from: self)
//    }
    
    /// YYSwift: Check if date is in leap year
    public var isLeapYear: Bool {
        let year = self.year
        return (year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0))
    }
    
    /// YYSwift: Check if date is within today.
    ///
    ///     Date().isToday -> true
    ///
    public var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    /// YYSwift: Check if date is within yesterday.
    ///
    ///     Date().isYesterday -> false
    ///
    public var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    /// YYSwift: Check if date is in future.
    ///
    ///     Date(timeInterval: 100, since: Date()).isFuture -> true
    ///
    public var isFuture: Bool {
        return self > Date()
    }
    
    /// YYSwift: Check if date is in past.
    ///
    ///     Date(timeInterval: -100, since: Date()).isPast -> true
    ///
    public var isPast: Bool {
        return self < Date()
    }
    
    /// YYSwift: Check if date is within tomorrow.
    ///
    ///     Date().isTomorrow -> false
    ///
    public var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    /// YYSwift: Check if date is within a weekend period.
    public var isWeekend: Bool {
        return Calendar.current.isDateInWeekend(self)
    }
    
    /// YYSwift: Check if date is within a weekday period.
    public var isWorkday: Bool {
        return !Calendar.current.isDateInWeekend(self)
    }
    
    /// YYSwift: Check if date is within the current week.
    public var isThisWeek: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    /// YYSwift: Check if date is within the current month.
    public var isThisMonth: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
    }
    
    /// YYSwift: Check if date is within the current year.
    public var isThisYear: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
    }
    
    /// YYSwift: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
    ///
    ///     Date().iso8601String -> "2017-01-12T14:51:29.574Z"
    ///
    public var iso8601String: String {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: self).appending("Z")
    }
    
    /// YYSwift: Time zone used currently by system.
    ///
    ///     Date().timeZone -> Europe/Istanbul (current)
    ///
    public var timeZone: TimeZone {
        return Calendar.current.timeZone
    }
    
    /// YYSwift: Number of days in the month of the date.
    public var numberOfDaysInMonth: Int {
        return Calendar.current.range(of: .day, in: .month, for: self)?.count ?? 0
    }
}

// MARK: - Methods
public extension Date {
    
    /// YYSwift: Date by adding multiples of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     let date2 = date.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///     let date3 = date.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///     let date4 = date.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///     let date5 = date.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of components to add.
    /// - Returns: original date + multiples of component added.
    public func adding(_ component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
    /// YYSwift: Add calendar component to date.
    ///
    ///     var date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     date.add(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///     date.add(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///     date.add(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///     date.add(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of compnenet to add.
    public mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = Calendar.current.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }
    
    /// YYSwift: Date by changing value of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     let date2 = date.changing(.minute, value: 10) // "Jan 12, 2017, 6:10 PM"
    ///     let date3 = date.changing(.day, value: 4) // "Jan 4, 2017, 7:07 PM"
    ///     let date4 = date.changing(.month, value: 2) // "Feb 12, 2017, 7:07 PM"
    ///     let date5 = date.changing(.year, value: 2000) // "Jan 12, 2000, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: new value of compnenet to change.
    /// - Returns: original date after changing given component to given value.
    public func changing(_ component: Calendar.Component, value: Int) -> Date? {
        switch component {
        case .nanosecond:
            let allowedRange = Calendar.current.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(value) else {
                return nil
            }
            let currentNanoseconds = Calendar.current.component(.nanosecond, from: self)
            let nanosecondsToAdd = value - currentNanoseconds
            return Calendar.current.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self)
            
        case .second:
            let allowedRange = Calendar.current.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(value) else {
                return nil
            }
            let currentSeconds = Calendar.current.component(.second, from: self)
            let secondsToAdd = value - currentSeconds
            return Calendar.current.date(byAdding: .second, value: secondsToAdd, to: self)
            
        case .minute:
            let allowedRange = Calendar.current.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(value) else {
                return nil
            }
            let currentMinutes = Calendar.current.component(.minute, from: self)
            let minutesToAdd = value - currentMinutes
            return Calendar.current.date(byAdding: .minute, value: minutesToAdd, to: self)
            
        case .hour:
            let allowedRange = Calendar.current.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(value) else {
                return nil
            }
            let currentHour = Calendar.current.component(.hour, from: self)
            let hoursToAdd = value - currentHour
            return Calendar.current.date(byAdding: .hour, value: hoursToAdd, to: self)
            
        case .day:
            let allowedRange = Calendar.current.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(value) else {
                return nil
            }
            let currentDay = Calendar.current.component(.day, from: self)
            let daysToAdd = value - currentDay
            return Calendar.current.date(byAdding: .day, value: daysToAdd, to: self)
            
        case .month:
            let allowedRange = Calendar.current.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(value) else {
                return nil
            }
            let currentMonth = Calendar.current.component(.month, from: self)
            let monthsToAdd = value - currentMonth
            return Calendar.current.date(byAdding: .month, value: monthsToAdd, to: self)
            
        case .year:
            guard value > 0 else {
                return nil
            }
            let currentYear = Calendar.current.component(.year, from: self)
            let yearsToAdd = value - currentYear
            return Calendar.current.date(byAdding: .year, value: yearsToAdd, to: self)
            
        default:
            return Calendar.current.date(bySetting: component, value: value, of: self)
        }
    }
    
    /// YYSwift: Data at the beginning of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:14 PM"
    ///     let date2 = date.beginning(of: .hour) // "Jan 12, 2017, 7:00 PM"
    ///     let date3 = date.beginning(of: .month) // "Jan 1, 2017, 12:00 AM"
    ///     let date4 = date.beginning(of: .year) // "Jan 1, 2017, 12:00 AM"
    ///
    /// - Parameter component: calendar component to get date at the beginning of.
    /// - Returns: date at the beginning of calendar component (if applicable).
    public func beginning(of component: Calendar.Component) -> Date? {
        
        if component == .day {
            return Calendar.current.startOfDay(for: self)
        }
        
        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]
                
            case .minute:
                return [.year, .month, .day, .hour, .minute]
                
            case .hour:
                return [.year, .month, .day, .hour]
                
            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]
                
            case .month:
                return [.year, .month]
                
            case .year:
                return [.year]
                
            default:
                return []
            }
        }
        
        guard !components.isEmpty else {
            return nil
        }
        return Calendar.current.date(from: Calendar.current.dateComponents(components, from: self))
    }
    
    /// YYSwift: Date at the end of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:27 PM"
    ///     let date2 = date.end(of: .day) // "Jan 12, 2017, 11:59 PM"
    ///     let date3 = date.end(of: .month) // "Jan 31, 2017, 11:59 PM"
    ///     let date4 = date.end(of: .year) // "Dec 31, 2017, 11:59 PM"
    ///
    /// - Parameter component: calendar component to get date at the end of.
    /// - Returns: date at the end of calendar component (if applicable).
    public func end(of component: Calendar.Component) -> Date? {
        switch component {
        case .second:
            var date = adding(.second, value: 1)
            date = Calendar.current.date(from:
                Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
            date.add(.second, value: -1)
            return date
            
        case .minute:
            var date = adding(.minute, value: 1)
            let after = Calendar.current.date(from:
                Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        case .hour:
            var date = adding(.hour, value: 1)
            let after = Calendar.current.date(from:
                Calendar.current.dateComponents([.year, .month, .day, .hour], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        case .day:
            var date = adding(.day, value: 1)
            date = Calendar.current.startOfDay(for: date)
            date.add(.second, value: -1)
            return date
            
        case .weekOfYear, .weekOfMonth:
            var date = self
            let beginningOfWeek = Calendar.current.date(from:
                Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
            date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
            return date
            
        case .month:
            var date = adding(.month, value: 1)
            let after = Calendar.current.date(from:
                Calendar.current.dateComponents([.year, .month], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        case .year:
            var date = adding(.year, value: 1)
            let after = Calendar.current.date(from:
                Calendar.current.dateComponents([.year], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        default:
            return nil
        }
    }
    
    /// YYSwift: Date string from date.
    ///
    ///     Date().string(withFormat: "dd/MM/yyyy") -> "1/12/17"
    ///     Date().string(withFormat: "HH:mm") -> "23:50"
    ///     Date().string(withFormat: "dd/MM/yyyy HH:mm") -> "1/12/17 23:50"
    ///
    /// - Parameter format: Date format (default is "dd/MM/yyyy").
    /// - Returns: date string.
    public func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    /// YYSwift: Date string from date.
    ///
    ///     Date().dateString(ofStyle: .short) -> "1/12/17"
    ///     Date().dateString(ofStyle: .medium) -> "Jan 12, 2017"
    ///     Date().dateString(ofStyle: .long) -> "January 12, 2017"
    ///     Date().dateString(ofStyle: .full) -> "Thursday, January 12, 2017"
    ///
    /// - Parameter style: DateFormatter style (default is .medium).
    /// - Returns: date string.
    public func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    /// YYSwift: Date and time string from date.
    ///
    ///     Date().dateTimeString(ofStyle: .short) -> "1/12/17, 7:32 PM"
    ///     Date().dateTimeString(ofStyle: .medium) -> "Jan 12, 2017, 7:32:00 PM"
    ///     Date().dateTimeString(ofStyle: .long) -> "January 12, 2017 at 7:32:00 PM GMT+3"
    ///     Date().dateTimeString(ofStyle: .full) -> "Thursday, January 12, 2017 at 7:32:00 PM GMT+03:00"
    ///
    /// - Parameter style: DateFormatter style (default is .medium).
    /// - Returns: date and time string.
    public func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    /// YYSwift: Time string from date
    ///
    ///     Date().timeString(ofStyle: .short) -> "7:37 PM"
    ///     Date().timeString(ofStyle: .medium) -> "7:37:02 PM"
    ///     Date().timeString(ofStyle: .long) -> "7:37:02 PM GMT+3"
    ///     Date().timeString(ofStyle: .full) -> "7:37:02 PM GMT+03:00"
    ///
    /// - Parameter style: DateFormatter style (default is .medium).
    /// - Returns: time string.
    public func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: self)
    }
    
    /// YYSwift: Check if date is in current given calendar component.
    ///
    ///     Date().isInCurrent(.day) -> true
    ///     Date().isInCurrent(.year) -> true
    ///
    /// - Parameter component: calendar component to check.
    /// - Returns: true if date is in current given calendar component.
    public func isInCurrent(_ component: Calendar.Component) -> Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: component)
    }
    
    /// YYSwift: Day name from date.
    ///
    ///     Date().dayName(ofStyle: .threeLetters) -> "Thu"
    ///     Date().dayName(ofStyle: .full) -> "Thursday"
    ///
    /// - Parameter Style: style of day name (default is DayNameStyle.full).
    /// - Returns: day name string (example: Wed, Wednesday).
    public func dayName(ofStyle style: DayNameStyle = .full) -> String {
        // http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .threeLetters:
                return "EEE"
            case .full:
                return "EEEE"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    /// YYSwift: Month name from date.
    ///
    ///     Date().monthName(ofStyle: .threeLetters) -> "Jan"
    ///     Date().monthName(ofStyle: .full) -> "January"
    ///
    /// - Parameter Style: style of month name (default is MonthNameStyle.full).
    /// - Returns: month name string (example: Dec, December).
    public func monthName(ofStyle style: MonthNameStyle = .full) -> String {
        // http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .threeLetters:
                return "MMM"
            case .full:
                return "MMMM"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    /// YYSwift: get number of seconds between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of seconds between self and given date.
    public func secondsSince(_ date: Date) -> Double {
        return timeIntervalSince(date)
    }
    
    /// YYSwift: get number of minutes between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of minutes between self and given date.
    public func minutesSince(_ date: Date) -> Double {
        return timeIntervalSince(date)/60
    }
    
    /// YYSwift: get number of hours between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of hours between self and given date.
    public func hoursSince(_ date: Date) -> Double {
        return timeIntervalSince(date)/3600
    }
    
    /// YYSwift: get number of days between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of days between self and given date.
    public func daysSince(_ date: Date) -> Double {
        return timeIntervalSince(date)/(3600*24)
    }
    
    /// YYSwift: check if a date is between two other dates
    ///
    /// - Parameters:
    ///   - startDate: start date to compare self to.
    ///   - endDate: endDate date to compare self to.
    ///   - includeBounds: true if the start and end date should be included (default is false)
    /// - Returns: true if the date is between the two given dates.
    public func isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
        if includeBounds {
            return startDate.compare(self).rawValue * compare(endDate).rawValue >= 0
        }
        return startDate.compare(self).rawValue * compare(endDate).rawValue > 0
    }
    
    /// YYSwift: check if a date is a number of date components of another date
    ///
    /// - Parameters:
    ///   - value: number of times component is used in creating range
    ///   - component: Calendar.Component to use.
    ///   - date: Date to compare self to.
    /// - Returns: true if the date is within a number of components of another date
    public func isWithin(_ value: UInt, _ component: Calendar.Component, of date: Date) -> Bool {
        let components = Calendar.current.dateComponents([component], from: self, to: date)
        let componentValue = components.value(for: component)!
        return abs(componentValue) <= value
    }
}

// MARK: - Initializers
public extension Date {

    public init?(
        calendar: Calendar? = Calendar.current,
        timeZone: TimeZone? = TimeZone.current,
        era: Int? = Date().era,
        year: Int? = Date().year,
        month: Int? = Date().month,
        day: Int? = Date().day,
        hour: Int? = Date().hour,
        minute: Int? = Date().minute,
        second: Int? = Date().second,
        nanosecond: Int? = Date().nanosecond) {
        
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.era = era
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond
        
        if let date = calendar?.date(from: components) {
            self = date
        } else {
            return nil
        }
    }

    /// YYSwift: Create date object from ISO8601 string.
    ///
    ///     let date = Date(iso8601String: "2017-01-12T16:48:00.959Z") // "Jan 12, 2017, 7:48 PM"
    ///
    /// - Parameter iso8601String: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
    public init?(iso8601String: String) {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: iso8601String) {
            self = date
        } else {
            return nil
        }
    }
    
    /// YYSwift: Create new date object from UNIX timestamp.
    ///
    ///     let date = Date(unixTimestamp: 1484239783.922743) // "Jan 12, 2017, 7:49 PM"
    ///
    /// - Parameter unixTimestamp: UNIX timestamp.
    public init(unixTimestamp: Double) {
        self.init(timeIntervalSince1970: unixTimestamp)
    }
    
}
#endif
