//
//  ContentView.swift
//  MiniCalendar
//
//  Created by SaberCon on 2025/1/13.
//

import SwiftUI

struct CalendarView: View {

    @AppStorage(SettingKeys.showChineseCalendar.rawValue)
    private var showChineseCalendar = true

    @Environment(\.openSettings) private var openSettings

    @State private var viewModel = CalendarViewModel()

    var body: some View {
        VStack {
            controlBar
                .padding(.bottom)

            Grid(horizontalSpacing: 12, verticalSpacing: 16) {
                calendarHeader

                let items = viewModel.dateItems
                ForEach(0..<6) { rowIndex in
                    let startIndex = rowIndex * 7
                    let row = items[startIndex..<(startIndex + 7)]
                    calendarRow(items: row)
                }
            }
        }
        .padding()
        .padding([.horizontal, .bottom])
        .fixedSize()
    }

    private var controlBar: some View {
        HStack {
            Button("Current month", systemImage: "arrow.clockwise") {
                viewModel.resetMonth()
            }
            .handCursorOnHover()
            .keyboardShortcut(.space, modifiers: [])
            .help("Current month")
            Spacer()

            Button("Previous month", systemImage: "chevron.backward") {
                viewModel.moveMonth(by: -1)
            }
            .handCursorOnHover()
            .keyboardShortcut(.leftArrow, modifiers: [])
            Text(viewModel.yearMonth)
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundStyle(.primary)
                .frame(minWidth: 130)
            Button("Next month", systemImage: "chevron.forward") {
                viewModel.moveMonth(by: 1)
            }
            .handCursorOnHover()
            .keyboardShortcut(.rightArrow, modifiers: [])

            Spacer()
            Button("Open preferences", systemImage: "ellipsis.circle") {
                NSApplication.shared.activate(ignoringOtherApps: true)
                openSettings()
            }
            .handCursorOnHover()
            .help("Open preferences")
        }
        .labelStyle(.iconOnly)
        .buttonStyle(.borderless)
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundStyle(.secondary)
    }

    private var calendarHeader: some View {
        GridRow {
            ForEach(viewModel.weekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private func calendarRow(items: some RandomAccessCollection<DateItem>)
        -> some View
    {
        GridRow {
            ForEach(items) { item in
                VStack {
                    Text("\(item.day)")
                        .font(.headline)
                    if showChineseCalendar {
                        ZStack {
                            Text("\(item.lunarDay)")
                            // Make sure all the boxes have the same size 😂
                            Text(verbatim: "三个字").opacity(0)
                        }
                        .font(.caption2)
                    }
                }
                .opacity(viewModel.isInCurrentMonth(item) ? 1 : 0.4)
                .background {
                    if viewModel.isToday(item) {
                        Circle()
                            .fill(Color.blue)
                            .scaledToFill()
                            .opacity(0.5)
                            .scaleEffect(showChineseCalendar ? 1.5 : 2)
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarView()
}
