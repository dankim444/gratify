//
//  RatingView2.swift
//  gratify
//
//  Created by Sam on 4/14/24.
//

import Foundation
import SwiftUI

struct RatingView2: View {
    @Binding var dailyEntry: DailyEntry
    @Binding var navigationPath: NavigationPath
    var viewModel: ViewModel

    var body: some View {
        Form {
            TextField("Entry 1", text: $dailyEntry.entry1) // maybe make the entry boxes a little bigger and more spaced out?
            TextField("Entry 2", text: $dailyEntry.entry2)
            TextField("Entry 3", text: $dailyEntry.entry3)
            Button("Submit") {
                viewModel.appendEntry(dailyEntry: dailyEntry)
                navigationPath = NavigationPath() // This will reset the navigation stack
                viewModel.printMonthlyData() // Optionally print data for debugging
            }
        }
        .navigationBarTitle("Detail Your Day")
    }
}
