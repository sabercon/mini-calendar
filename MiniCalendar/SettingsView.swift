//
//  SettingsView.swift
//  MiniCalendar
//
//  Created by SaberCon on 2025/1/14.
//

import KeyboardShortcuts
import LaunchAtLogin
import ServiceManagement
import SwiftUI

enum SettingKeys: String {
    case showChineseCalendar
    case toggleCalendar
}

struct SettingsView: View {

    @AppStorage(SettingKeys.showChineseCalendar.rawValue)
    private var showChineseCalendar = true

    var body: some View {
        Form {
            Section("General") {
                LaunchAtLogin.Toggle("Launch at login" as LocalizedStringKey)

                Toggle("Show Chinese calendar", isOn: $showChineseCalendar)
            }

            Section("Customized Shortcuts") {
                KeyboardShortcuts
                    .Recorder("Toggle calendar", name: .toggleCalendar)
            }

            Section("Built-in Shortcuts") {
                shortcutTip(name: "Previous month", shortcut: "Left arrow ←")
                shortcutTip(name: "Next month", shortcut: "Right arrow →")
                shortcutTip(name: "Current month", shortcut: "Space ␣")
                shortcutTip(name: "Close window", shortcut: "Esc ⎋")
                shortcutTip(name: "Open preferences", shortcut: "⌘,")
                shortcutTip(name: "Quit", shortcut: "⌘q")
            }
        }
        .formStyle(.grouped)
        .frame(idealWidth: 400)
        .fixedSize()
    }

    private func shortcutTip(name: LocalizedStringKey, shortcut: LocalizedStringKey) -> some View {
        HStack {
            Text(name)
            Spacer()
            Text(shortcut)
        }
    }
}

#Preview {
    SettingsView()
}
