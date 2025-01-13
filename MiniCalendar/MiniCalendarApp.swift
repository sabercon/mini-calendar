//
//  MiniCalendarApp.swift
//  MiniCalendar
//
//  Created by SaberCon on 2025/1/13.
//

import KeyboardShortcuts
import SwiftUI

@main
struct MiniCalendarApp: App {

    @State private var appState = AppState()

    var body: some Scene {
        MenuBarExtra("Mini Calendar", systemImage: "calendar") {
            CalendarView()
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView()
        }
        .defaultSize(width: 400, height: 400)
    }
}

@MainActor
@Observable
final class AppState {

    init() {
        KeyboardShortcuts.onKeyUp(for: .toggleCalendar) {
            if let window = NSApplication.shared.windows
                .first(where: { $0.className.contains("MenuBarExtraWindow") })
            {
                if window.isVisible {
                    window.orderOut(nil)
                } else {
                    window.makeKeyAndOrderFront(nil)
                }
            }
        }
    }
}
