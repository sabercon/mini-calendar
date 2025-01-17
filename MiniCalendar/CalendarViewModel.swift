//
//  CalendarViewModel.swift
//  MiniCalendar
//
//  Created by SaberCon on 2025/1/13.
//

import Foundation

@Observable
final class CalendarViewModel {

    private let cal = Calendar.autoupdatingCurrent

    var currentMonth: Date

    init() {
        currentMonth = cal.startOfMonth(for: Date())
    }

    var yearMonth: String {
        currentMonth.formatted(.dateTime.year(.defaultDigits).month(.wide))
    }

    var weekdaySymbols: [String] {
        cal.shortWeekdaySymbols
    }

    var dateItems: [DateItem] {
        let offset = 1 - cal.component(.weekday, from: currentMonth)
        let startDate = cal.addingDays(offset, to: currentMonth)
        return (0..<(7 * 6))
            .map { DateItem(date: cal.addingDays($0, to: startDate)) }
    }

    func resetMonth() {
        currentMonth = cal.startOfMonth(for: Date())
    }

    func moveMonth(by n: Int) {
        currentMonth = cal.addingMonths(n, to: currentMonth)
    }

    func isToday(_ dateItem: DateItem) -> Bool {
        cal.isDateInToday(dateItem.date)
    }

    func isInCurrentMonth(_ dateItem: DateItem) -> Bool {
        cal.isInSameMonth(dateItem.date, currentMonth)
    }
}

struct DateItem: Identifiable {
    private static let lunarFormatter = {
        let fmt = DateFormatter()
        fmt.calendar = Calendar.lunar
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.dateStyle = .medium
        return fmt
    }()

    private static let lunarPattern = /\d+年(\w+月)(\w+)/

    let id = UUID()
    let date: Date

    var day: Int {
        Calendar.autoupdatingCurrent.component(.day, from: date)
    }

    var lunarDay: String {
        let lunarDateString = Self.lunarFormatter.string(from: date)
        if let match = lunarDateString.wholeMatch(of: Self.lunarPattern) {
            let (_, month, day) = match.output
            return String("初一" == day ? month : day)
        } else {
            print("Invalid lunar date string: \(lunarDateString)")
            return ""
        }
    }
}
