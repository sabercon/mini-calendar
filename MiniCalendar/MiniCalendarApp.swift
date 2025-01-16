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
        .defaultSize(width: 400, height: 550)
    }
}

@MainActor
@Observable
final class AppState {

    init() {
        KeyboardShortcuts.onKeyUp(for: .toggleCalendar) {
            Self.toggleMenuBarWindow()
        }

        // Add ESC key monitoring
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            guard event.keyCode == 53 else { return event }

            Self.closeMenubarWindow()
            return nil  // Consume the event
        }
    }

    private static func toggleMenuBarWindow() {
        if let window = menuBarWindow() {
            if window.isVisible {
                window.orderOut(nil)
            } else {
                window.makeKeyAndOrderFront(nil)
            }
        }
    }

    private static func closeMenubarWindow() {
        if let window = menuBarWindow(), window.isVisible {
            window.orderOut(nil)
        }
    }

    private static func menuBarWindow() -> NSWindow? {
        NSApplication.shared.windows
            .first(where: { $0.className.contains("MenuBarExtraWindow") })
    }
}
