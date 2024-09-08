//
//  EntriesView.swift
//  gratify
//
//  Created by Daniel Kim on 4/14/24.
//

import Foundation
import SwiftUI

struct EntriesView: View {
    @Binding var navigationPath: NavigationPath
    @ObservedObject var viewModel: ViewModel

    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var viewFormat: ViewFormat = .list
    @State private var showAllEntries: Bool = false

    enum ViewFormat {
        case list, grid
    }

    @State private var months: [String] = Calendar.current.monthSymbols
    @State private var years: [Int] = Array(2000...2040)

    var body: some View {
        VStack {
            // Month and Year Picker in an HStack
            HStack {
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1..<13, id: \.self) { month in
                        Text(months[month - 1]).tag(month)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(minWidth: 100)

                Picker("Year", selection: $selectedYear) {
                    ForEach(years, id: \.self) { year in
                        Text(String(year)).tag(year)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(minWidth: 100)
            }
            .padding()

            Picker("View Format", selection: $viewFormat) {
                Text("List").tag(ViewFormat.list)
                Text("Grid").tag(ViewFormat.grid)
            }
            .pickerStyle(.segmented)
            .padding()

            Button("View All") {
                showAllEntries.toggle()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            // Main content area
            contentView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Bottom bar with home button
            Button(action: {
                navigationPath = NavigationPath()
            }) {
                Image(systemName: "house.fill")
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(5)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .navigationBarTitle("All Entries")
    }
    
    var filteredEntries: [DailyEntry] {
        if showAllEntries {
            return viewModel.entries
        } else {
            return viewModel.entries.filter {
                let entryMonth = Calendar.current.component(.month, from: $0.date)
                let entryYear = Calendar.current.component(.year, from: $0.date)
                return entryMonth == selectedMonth && entryYear == selectedYear
            }
        }
    }

    @ViewBuilder
    var contentView: some View {
        if filteredEntries.isEmpty {
            Text("No entries here.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .multilineTextAlignment(.center)
        } else {
            switch viewFormat {
            case .list:
                List(filteredEntries, id: \.id) { entry in
                    EntryView(entry: entry)
                }
            case .grid:
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                        ForEach(filteredEntries, id: \.id) { entry in
                            EntryView(entry: entry)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

// used to truncate text
extension String {
    func prefix(maxLength: Int) -> String {
        if self.count > maxLength {
            let index = self.index(self.startIndex, offsetBy: maxLength)
            return String(self.prefix(upTo: index)) + "..."
        }
        return self
    }
}

struct EntryView: View {
    var entry: DailyEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Score: \(entry.score) / 7")
            Text("Date: \(entry.date, formatter: itemFormatter)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if (entry.entry1.count > 20) {
                Text("Entry 1: \(entry.entry1.prefix(20))...") // Display only the first 20 characters
            } else {
                Text("Entry 1: \(entry.entry1)")
            }
            
            if (entry.entry2.count > 20) {
                Text("Entry 2: \(entry.entry2.prefix(20))...") // Display only the first 20 characters
            } else {
                Text("Entry 2: \(entry.entry2)")
            }
            
            if (entry.entry3.count > 20) {
                Text("Entry 3: \(entry.entry3.prefix(20))...") // Display only the first 20 characters
            } else {
                Text("Entry 3: \(entry.entry3)")
            }
        }
    }
    
    private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
}
