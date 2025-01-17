//
//  Extensions.swift
//  MiniCalendar
//
//  Created by SaberCon on 2025/1/13.
//

import KeyboardShortcuts
import SwiftUI

extension View {
    func handCursorOnHover() -> some View {
        onHover { hovering in
            if hovering {
                NSCursor.pointingHand.push()
            } else {
                NSCursor.pop()
            }
        }
    }
}

extension Calendar {

    static let lunar = {
        var cal = Calendar(identifier: .chinese)
        cal.locale = Locale(identifier: "zh_CN")
        return cal
    }()

    func startOfMonth(for date: Date) -> Date {
        self.date(from: dateComponents([.year, .month], from: date))!
    }

    func addingDays(_ n: Int, to date: Date) -> Date {
        self.date(byAdding: .day, value: n, to: date)!
    }

    func addingMonths(_ n: Int, to date: Date) -> Date {
        self.date(byAdding: .month, value: n, to: date)!
    }

    func isInSameMonth(_ date1: Date, _ date2: Date) -> Bool {
        isDate(date1, equalTo: date2, toGranularity: .month)
    }
}

extension KeyboardShortcuts.Name {
    static let toggleCalendar = Self(SettingKeys.toggleCalendar.rawValue)
}
