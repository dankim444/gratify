//
//  YearlyView.swift
//  gratify
//
//  Created by Daniel Kim on 4/22/24.
//

import Foundation
import SwiftUI

struct YearlyView: View {
    @Binding var navigationPath: NavigationPath
    @ObservedObject var viewModel: ViewModel
    @State private var summaryResponse: SummaryResponse?
    
    var currentYearEntries: [DailyEntry] {
        let calendar = Calendar.current
        let now = Date()
        let currentYear = calendar.component(.year, from: now)

        return viewModel.entries.filter {
            let entryYear = calendar.component(.year, from: $0.date)
            return entryYear == currentYear
        }
    }
    
    // function that converts a single DailyEntry into a string
    func formatEntry(_ entry: DailyEntry) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let dateString = dateFormatter.string(from: entry.date)
        return "Date: \(dateString), Score: \(entry.score), Entry 1: \(entry.entry1), Entry 2: \(entry.entry2), Entry 3: \(entry.entry3)"
    }
    
    // function that combines all entries into a single string
    func entriesToString(entries: [DailyEntry]) -> String {
        return entries.map { formatEntry($0) }.joined(separator: "\n\n")
    }
    
    func prepareAndFetchGPTMessage() async throws {
        do {
            let entriesString = entriesToString(entries: currentYearEntries)
            let response = try await OpenAIService.shared.fetchGPTMessage(message: entriesString)
            DispatchQueue.main.async {
                self.summaryResponse = response
            }
        } catch {
            print("Error fetching message: \(error)")
            DispatchQueue.main.async {
                self.summaryResponse = nil // Clear previous data or indicate error
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("yearly")
            Button("go to monthly") {
                navigationPath.removeLast()
            }
            
            if let summary = summaryResponse {
                Text("Overall Mood: \(summary.overallMood)")
                Text("Overall Rating: \(summary.overallRating)")
                Text("Top 5 Mindful Things: \(summary.top5MindfulStuff)")
                Text("Random Home Page Number: \(summary.homePageNumber)")
                    .padding()
            } else {
                Text("No summary available yet")
                    .padding()
            }
            
            Button(action: {
                navigationPath = NavigationPath()
            }) {
                Image(systemName: "homekit")
                    .padding()
                    .background(.purple)
                    .cornerRadius(5)
                    .foregroundStyle(.white)
            }
        }
        .onAppear {
            Task {
                try await prepareAndFetchGPTMessage()
            }
        }
        .navigationBarTitle("Yearly")
    }
}
