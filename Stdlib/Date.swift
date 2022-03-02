import Foundation

enum DateFormat: String {
    case fullISO8601DateFormat = "yyyy-MM-ddTHH:mm:ss.sTZD"
    case serverTimeFormart = "dd-MM-yyyy HH:mm:ss"
    case yyyyMMdd_HHmmss = "yyyy-MM-dd HH:mm:ss"
    case dd_MM_yyyy = "dd-MM-yyyy"
    case ddMMyyyy = "dd/MM/yyyy"
    case ddMM = "dd/MM"
    case HHmm = "HH:mm"
}

extension Date {
    static 
    var calendar: Calendar {
        var calendar = Calendar.current
        calendar.locale = Locale.current
        return calendar
    }

    static 
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale.current
        return dateFormatter
    }
}

extension Date {
    var hour: Int {
        return Date.calendar.component(.hour, from: self)
    }
    
    var minute: Int {
        return Date.calendar.component(.minute, from: self)
    }

    var second: Int {
        return Date.calendar.component(.second, from: self)
    }

    var year: Int? {
        let components = Date.calendar.dateComponents([.year], from: self)
        return components.year
    }
    
    var month: Int? {
        let components = Date.calendar.dateComponents([.month], from: self)
        return components.month
    }
    
    var day: Int? {
        let components = Date.calendar.dateComponents([.day], from: self)
        return components.day
    }

    // slider
    var startOfDay: Date {
        return Date.calendar.date(bySettingHour: 0, minute: 0, second: 0, of: self) ?? Date()
    }
    
    var endOfDay: Date {
        return Date.calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self) ?? Date()
    }
    
    var startOfMonth: Date {
        return Date.calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self.startOfDay))!
    }
    
    var endOfMonth: Date {
        return Date.calendar.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth.endOfDay)!
    }
}

extension Date {
    func compute(sinceDate: Date) -> DateComponents? {
        let delta = self.timeIntervalSince(sinceDate)
        let today = Date()
        let calendar = Calendar.current
        var components: DateComponents?
        if delta < 0 {
            components = calendar.dateComponents([.year, .month, .day], from: today)
        } else {
            components = calendar.dateComponents([.year, .month, .day], from: today.addingTimeInterval(delta))
        }
        return components
    }

    func add(_ unit: Calendar.Component, value: Int) -> Date? {
        return Date.calendar.date(byAdding: unit, value: value, to: self)
    }

    func isSameDay(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.compare(self, to: date, toGranularity: .day) == ComparisonResult.orderedSame
    }

    func isBefore(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.compare(self, to: date, toGranularity: .day) == ComparisonResult.orderedAscending
    }

    func isAfter(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.compare(self, to: date, toGranularity: .day) == ComparisonResult.orderedDescending
    }
    
    func isEqualTo(_ date: Date) -> Bool {
      return self == date
    }
}

extension Date {
    /// Note that timezone from GMT need to be .current
    func toString(format: String) -> String {
        let fmt: DateFormatter = DateFormatter()
        fmt.dateFormat = format
        
        fmt.timeZone = TimeZone.current
        fmt.locale = Locale.current

        return fmt.string(from: self)
    }
}

extension String {
    /// Note that timezone from GMT need to be 0
    func toDate(format: String) -> Date? {
        let fmt: DateFormatter = DateFormatter()
        fmt.dateFormat = format

        fmt.timeZone = TimeZone(secondsFromGMT: 0)
        fmt.locale = Locale.current
        
        return fmt.date(from: self)
    }
}

do {
    // let x = "12:01 Wed, 30 Oct 2021"
    //             .toDate(format: "HH:mm E, d MMM y")
    // let y = Date()
    // var z = Date()
    // z = z.add(.day, value: 3)!

    // print(x ?? "No")
    // print(y.toString(format: "dd/MM/yyyy HH:mm:ss"))
    // print(x?.add(.day, value: 3))
    
    // var z = Date(timeIntervalSince1970: 0)
    // if let temp = z.add(.second, value: 10) {
    //     z = temp
    // }
    // print(z.toString(format: "dd/MM/yyyy HH:mm:ss"))

    // let a1 = y.timeIntervalSince1970
    // let a2 = z.timeIntervalSince1970
    // let res = (a1-a2) / (24*60*60)
    // print(abs(res))
}