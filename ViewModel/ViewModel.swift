//
//  ViewModel.swift
//  gratify
//
//  Created by Daniel Kim on 9/8/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var dailyEntry = DailyEntry(score: 0, entry1: "", entry2: "", entry3: "", date: Date())
    @Published var entries = [DailyEntry]() // Stores all entries

    func appendEntry(dailyEntry: DailyEntry) {
            entries.append(dailyEntry)
            resetDailyEntry()
    }

    private func resetDailyEntry() {
        // Reset dailyEntry to start with a blank slate each time after submission
        dailyEntry = DailyEntry(score: 0, entry1: "", entry2: "", entry3: "", date: Date())
    }
    
    // Function to print all monthly data
    func printMonthlyData() {
        for entry in entries {
            print("------------")
            print("Score: \(entry.score), Entry 1: \(entry.entry1), Entry 2: \(entry.entry2), Entry 3: \(entry.entry3)")
        }
    }
}
