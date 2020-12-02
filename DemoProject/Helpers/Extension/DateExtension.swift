//
//  DateExtension.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    // MARK:- DATE FORMAT ENUM
    //==========================
    enum DateFormat : String {
        case yyyy_MM_dd = "yyyy-MM-dd"
        case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
        case yyyyMMddTHHmmssz = "yyyy-MM-dd'T'HH:mm:ssZ"
        case yyyyMMddTHHmmssssZZZZZ = "yyyy-MM-dd'T'HH:mm:ss.ssZZZZZ"
        case yyyyMMdd = "yyyy/MM/dd"
        case dMMMyyyy = "d MMM, yyyy"
        case ddMMMyyyy = "dd MMM, yyyy"
        case MMMdyyyy = "MMM d, yyyy"
        case hmmazzz = "h:mm a zzz"
        case MMMdhhmma = "MMM d, hh:mm a"
        case hhmma = "hh:mm a"
        case yyyyMMDDHHmm = "yyyy/MM/dd hh:mm a"
    }
    
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    var todayDate: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var currentHour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    var currentMinute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    var currentTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.hhmma.rawValue
        let strDate = dateFormatter.string(from: self)
        return strDate
    }

    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var isYesterday:Bool{
        return Calendar.current.isDateInYesterday(self)
    }
    
    var isTomorrow:Bool{
        return Calendar.current.isDateInTomorrow(self)
    }
    
    var isWeekend:Bool{
        return Calendar.current.isDateInWeekend(self)
    }
    
    var year:Int{
        return (Calendar.current as NSCalendar).components(.year, from: self).year!
    }
    
    var month:Int{
        return (Calendar.current as NSCalendar).components(.month, from: self).month!
    }
    
    var weekOfYear:Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: self).weekOfYear!
    }
    
    var weekday:Int{
        return (Calendar.current as NSCalendar).components(.weekday, from: self).weekday!
    }
    
    var weekdayOrdinal:Int{
        return (Calendar.current as NSCalendar).components(.weekdayOrdinal, from: self).weekdayOrdinal!
    }
    
    var weekOfMonth:Int{
        return (Calendar.current as NSCalendar).components(.weekOfMonth, from: self).weekOfMonth!
    }
    
    var day:Int{
        return (Calendar.current as NSCalendar).components(.day, from: self).day!
    }
    
    var hour:Int{
        return (Calendar.current as NSCalendar).components(.hour, from: self).hour!
    }
    
    var minute:Int{
        return (Calendar.current as NSCalendar).components(.minute, from: self).minute!
    }
    
    var second:Int{
        return (Calendar.current as NSCalendar).components(.second, from: self).second!
    }
        
    var unixTimestamp:Double {
        return self.timeIntervalSince1970
    }
    
    //convert into millisecond
    var millisecondsSince1970: Double {
        return Double((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    //convert into date from milliseconds
    init(milliseconds: Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func isSameDay(date: Date) -> Bool {
        let components1 = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let components2 = Calendar.current.dateComponents([.year, .month, .day], from: date)
        if components1.year == components2.year && components1.month == components2.month && components1.day == components2.day {
            return true
        } else {
            return false
        }
    }
    
    func isSameYear(date: Date) -> Bool {
        let components1 = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let components2 = Calendar.current.dateComponents([.year, .month, .day], from: date)
        if components1.year == components2.year {
            return true
        } else {
            return false
        }
    }
    
    func yearsFrom(_ date:Date) -> Int {
        return (Calendar.current as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }
    
    func monthsFrom(_ date:Date) -> Int {
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }
    
    func weeksFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    
    func weekdayFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekday, from: date, to: self, options: []).weekday!
    }
    
    func weekdayOrdinalFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekdayOrdinal, from: date, to: self, options: []).weekdayOrdinal!
    }
    
    func weekOfMonthFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfMonth, from: date, to: self, options: []).weekOfMonth!
    }
    
    func daysFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
    
    func hoursFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }
    
    func minutesFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
    
    func secondsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    
    func getSecond() -> Int {
        let second = Calendar.current.component(.second, from: self)
        return second
    }
    
     func offsetFrom(date : Date) -> Int {
            let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
            let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)
            let seconds = (difference.second ?? 0) * 1000
            let minutes = (difference.minute ?? 0) * 60000 + seconds
            let hours = (difference.hour ?? 0) * 60 * 60000 + minutes
            let minutesInADay = 24 * 60
            let updatedData = 60 * 60000
            let daysData = (difference.day ?? 0) * minutesInADay * updatedData
            let days = (daysData + hours)
            if let day = difference.day, day          > 0 { return days }
            if let hour = difference.hour, hour       > 0 { return hours }
            if let minute = difference.minute, minute > 0 { return minutes }
            if let second = difference.second, second > 0 { return seconds }
            return 0
        }
        
        ///Converts a given Date into String based on the date format and timezone provided
        func toString(dateFormat:String,timeZone:TimeZone = TimeZone.current)->String{
            
            let frmtr = DateFormatter()
            frmtr.locale = Locale(identifier: "en_US_POSIX")
            frmtr.dateFormat = dateFormat
            frmtr.timeZone = timeZone
            return frmtr.string(from: self)
        }
        
        func toDDMMMYYYY(timeZone:TimeZone = TimeZone.current) -> String {
            let frmtr = DateFormatter()
            frmtr.locale = Locale(identifier: "en_US_POSIX")
            frmtr.timeZone = timeZone
            return "\(self.day):\(self.month):\(self.year)"
        }
        
        func toMMMYYYY(timeZone:TimeZone = TimeZone.current) -> String {
            let frmtr = DateFormatter()
            frmtr.locale = Locale(identifier: "en_US_POSIX")
            frmtr.timeZone = timeZone
            return "\(self.month):\(self.year)"
        }
        
        func calculateAge() -> Int {
            let currentDate = TrueTimeManager.shared.currentTime
            let calendar : Calendar = Calendar.current
            let unitFlags : NSCalendar.Unit = [NSCalendar.Unit.year , NSCalendar.Unit.month , NSCalendar.Unit.day]
            let dateComponentNow : DateComponents = (calendar as NSCalendar).components(unitFlags, from: currentDate)
            let dateComponentBirth : DateComponents = (calendar as NSCalendar).components(unitFlags, from: self)
            
            if ( (dateComponentNow.month! < dateComponentBirth.month!) ||
                ((dateComponentNow.month! == dateComponentBirth.month!) && (dateComponentNow.day! < dateComponentBirth.day!))
                )
            {
                return dateComponentNow.year! - dateComponentBirth.year! - 1
            }
            else {
                return dateComponentNow.year! - dateComponentBirth.year!
            }
        }
        
        static func zero() -> Date {
            let dateComp = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, era: 0, year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0, nanosecond: 0, weekday: 0, weekdayOrdinal: 0, quarter: 0, weekOfMonth: 0, weekOfYear: 0, yearForWeekOfYear: 0)
            return dateComp.date!
        }
        
        func convertToString() -> String {
            // First, get a Date from the String
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormat.yyyyMMddTHHmmssz.rawValue
            
            // Now, get a new string from the Date in the proper format for the user's locale
            dateFormatter.dateFormat = nil
            dateFormatter.dateStyle = .long // set as desired
            dateFormatter.timeStyle = .medium // set as desired
            let local = dateFormatter.string(from: self)
            return local
        }
        
        
        var timeAgoSince : String {
            
            let calendar = Calendar.current
            let now = TrueTimeManager.shared.currentTime
            let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
            let components = (calendar as NSCalendar).components(unitFlags, from: self, to: now, options: [])
            
            let year = abs(components.year ?? 0)
            let month = abs(components.month ?? 0)
            let week = abs(components.weekOfYear ?? 0)
            let day = abs(components.day ?? 0)
            let hour = abs(components.hour ?? 0)
            let minute = abs(components.minute ?? 0)
            _ = abs(components.second ?? 0)
            
            if year >= 2 {
                return "\(year)y"
            }
            
            if year >= 1 {
                return "1y"
            }
            
            if month >= 2 {
                return "\(month)m"
            }
            
            if month >= 1 {
                return "1m"
            }
            
            if week >= 2 {
                return "\(week)w"
            }
            
            if week >= 1 {
                return "1w"
            }
            
            if day >= 2 {
                return "\(day)d"
            }
            
            if day >= 1 {
                return "1d"
            }
            
            if hour >= 2 {
                return "\(hour)hrs"
            }
            
            if hour >= 1 {
                return "1h"
            }
            
            if minute >= 2 {
                return "\(minute)m"
            }
            
            if minute >= 1 {
                return "1m"
            }
            
    //        if second >= 3 {
    //            return "\(second) sec"
    //        }
    //
            return "just now"
        }
        
        var fulltimeAgoSince : String {
            
            let calendar = Calendar.current
            let now = TrueTimeManager.shared.currentTime
            let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
            let components = (calendar as NSCalendar).components(unitFlags, from: self, to: now, options: [])
            
            if let year = components.year, year >= 2 {
                return "\(year) years"
            }
            
            if let year = components.year, year >= 1 {
                return "1 year"
            }
            
            if let month = components.month, month >= 2 {
                return "\(month) months"
            }
            
            if let month = components.month, month >= 1 {
                return "1 month"
            }
            
            if let week = components.weekOfYear, week >= 2 {
                return "\(week) weeks"
            }
            
            if let week = components.weekOfYear, week >= 1 {
                return "1 week"
            }
            
            if let day = components.day, day >= 2 {
                return "\(day) days"
            }
            
            if let day = components.day, day >= 1 {
                return "1 day"
            }
            
            if let hour = components.hour, hour >= 2 {
                return "\(hour) hours"
            }
            
            if let hour = components.hour, hour >= 1 {
                return "1 hour"
            }
            
            if let minute = components.minute, minute >= 2 {
                return "\(minute) minutes"
            }
            
            if let minute = components.minute, minute >= 1 {
                return "1 minute"
            }
            
            if let second = components.second, second >= 3 {
                return "\(second) seconds"
            }
            
            return "now"
        }
        
        // =========== Message Time ===========
        static func getTimeWith(milliseconds: String) -> String {
            if let timestampInMs = Double(milliseconds) {
                let msgDate = Date(timeIntervalSince1970: timestampInMs*0.001)
                let formattedDate = Date.previousDayDifference(from: msgDate, format: "MMM dd")
                let time = Date.toString(from: msgDate, usingFormat: "h:mm a")
                let combinedTxt = formattedDate + " · " + time
                return combinedTxt
            }
            return ""
        }
        
        static func previousDayDiff(from date : Date, format : String) -> String {
            let calendar = NSCalendar.current
            if calendar.isDateInYesterday(date) { return "yesterday" }
            else if calendar.isDateInToday(date) { return "today" }
            else { return Date.toString(from: date, usingFormat: format) }
        }
        
        static func getTimeStringWith(milliseconds: String) -> String {
            if let timestampInMs = Double(milliseconds) {
                let msgDate = Date(timeIntervalSince1970: timestampInMs*0.001)
                let formattedDate = Date.toString(from: msgDate, usingFormat: "M/d")
                let time = Date.toString(from: msgDate, usingFormat: "h:mm a")
                let combinedTxt = formattedDate + ", " + time
                return combinedTxt
            }
            return ""
        }
        
        static func previousDayDifference(from date : Date, format : String) -> String {
            let calendar = NSCalendar.current
            if calendar.isDateInYesterday(date) { return "yesterday" }
            else if calendar.isDateInToday(date) { return "today" }
            else if Date.ifDateisInPreviousSevenDays(date: date) { return Date.toString(from: date, usingFormat: "EEEE") }
            else { return Date.toString(from: date, usingFormat: format) }
        }
        
        static func ifDateisInPreviousSevenDays(date : Date) -> Bool{
            
            let threshold = Date(timeIntervalSinceNow: -(7*24*60*60))
            return date >= threshold
        }
        
        static func toString(from date: Date?, usingFormat format : String) -> String {
            
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = format
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            dateFormatter.timeZone = TimeZone.current
            let currentDate = TrueTimeManager.shared.currentTime
            let formattedDate : String = dateFormatter.string(from: date ?? currentDate)
            return formattedDate
        }
        
}
