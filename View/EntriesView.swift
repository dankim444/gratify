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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DayEntry.date, ascending: false)],
        animation: .default
    )
    private var entries: FetchedResults<DayEntry>
    
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
        
        
        ZStack {
 

            VStack {
                // Month and Year Picker in an HStack
                Spacer()
                HStack {
                    Text("JOURNAL")
                        .font(Font.custom("Futura-Medium", size: 40))
                        .foregroundColor(Color.black)
                }
                
//                Picker("View Format", selection: $viewFormat) {
//                    Text("List").tag(ViewFormat.list)
//                    Text("Grid").tag(ViewFormat.grid)
//                }
//                .pickerStyle(.segmented)
//                .padding()
                Toggle(isOn: $showAllEntries) {
                    Text("Show All Entries")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .tint(.black)
                }
                .tint(.black)
                .padding(.horizontal, 60)
                .padding( .vertical, 10)
                
                
                if !showAllEntries {
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
                    .frame(minWidth: 200, minHeight: 30)
                    .background(
                        Color(red: 238/255, green: 238/255, blue: 239/255))
                    .cornerRadius(8)
                } else {
                    Text("")
                        .padding()
                }
                
                // Main content area
                contentView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                
                // Bottom bar with home button
                Button(action: {
                    navigationPath = NavigationPath()
                }) {
                    Text("Home")
                    .fontWeight(.semibold)
                    .frame(width: 200)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2))
                }
                .padding()
            }
        }
        
        .navigationBarBackButtonHidden(true)
        
        // View ends here
    }
    
    var filteredEntries: [DayEntry] {
        if showAllEntries {
            return Array(entries)
        } else {
            return entries.filter { entry in
                let entryMonth = Calendar.current.component(.month, from: entry.date ?? Date())
                let entryYear = Calendar.current.component(.year, from: entry.date ?? Date())
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
                List(filteredEntries, id: \.self) { entry in
                    EntryView(entry: entry)
                }
            case .grid:
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                        ForEach(filteredEntries, id: \.self) { entry in
                            EntryView(entry: entry)
                        }
                    }
                    .padding()
                }
            }
        }
        
    }
    
}

struct EntryView: View {
    var entry: DayEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Score: \(entry.rating) / 7")
            Text("Date: \(entry.date ?? Date(), formatter: itemFormatter)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if let summary1 = entry.summary1, summary1.count > 20 {
                Text("Entry 1: \(String(summary1.prefix(20)))...")
            } else {
                Text("Entry 1: \(entry.summary1 ?? "N/A")")
            }
            
            if let summary2 = entry.summary2, summary2.count > 20 {
                Text("Entry 2: \(String(summary2.prefix(20)))...")
            } else {
                Text("Entry 2: \(entry.summary2 ?? "N/A")")
            }
            
            if let summary3 = entry.summary3, summary3.count > 20 {
                Text("Entry 3: \(String(summary3.prefix(20)))...")
            } else {
                Text("Entry 3: \(entry.summary3 ?? "N/A")")
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

#Preview {
    EntriesView(navigationPath: .constant(NavigationPath()))
}
