//
//  SettingsView.swift
//  MiniCalendar
//
//  Created by SaberCon on 2025/1/14.
//

import KeyboardShortcuts
import ServiceManagement
import SwiftUI

enum SettingKeys: String {
    case launchAtLogin
    case showChineseCalendar
    case toggleCalendar
}

struct SettingsView: View {

    @AppStorage(SettingKeys.launchAtLogin.rawValue)
    private var launchAtLogin = false

    @AppStorage(SettingKeys.showChineseCalendar.rawValue)
    private var showChineseCalendar = true

    var body: some View {
        Form {
            Section {
                Toggle("Launch at login", isOn: $launchAtLogin)
                    .onChange(of: launchAtLogin, toggleLaunchAtLogin)

                Toggle("Show Chinese calendar", isOn: $showChineseCalendar)
            }

            Section {
                KeyboardShortcuts
                    .Recorder("Toggle calendar", name: .toggleCalendar)
            }
        }
        .formStyle(.grouped)
    }

    private func toggleLaunchAtLogin(oldState: Bool, newState: Bool) {
        do {
            if newState {
                try SMAppService.mainApp.register()
            } else {
                try SMAppService.mainApp.unregister()
            }
        } catch {
            print(
                "Failed to \(newState ? "register" : "unregister") launch at login: \(error)"
            )
            launchAtLogin = oldState  // Revert the toggle if operation fails
        }
    }
}

#Preview {
    SettingsView()
        .frame(maxWidth: 400, maxHeight: 400)
}
