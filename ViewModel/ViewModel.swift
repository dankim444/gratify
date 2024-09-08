//
//  ViewModel.swift
//  gratify
//
//  Created by Daniel Kim on 9/8/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var dailyEntry: DayEntry?
    @Published var showRatingView2 = false
    @Published var summaryResponse: SummaryResponse?
    
    func fetchSummary(message: String) {
        Task {
            do {
                let summary = try await OpenAIService.shared.fetchGPTMessage(message: message)
                DispatchQueue.main.async {
                    self.summaryResponse = summary
                }
            } catch {
                print("Error fetching summary: \(error)")
            }
        }
    }
    
    func createNewDailyEntry() {
        dailyEntry = DayEntry(context: CoreDataManager.shared.managedContext)
    }

    private func resetDailyEntry() {
        dailyEntry = nil
    }
}

