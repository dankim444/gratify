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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DayEntry.date, ascending: false)],
        animation: .default
    )
    private var entries: FetchedResults<DayEntry>
    
    var body: some View {
        VStack {
            Text("your yearly")
                .font(Font.custom("Futura-MediumItalic", size: 35))
                .foregroundColor(Color.black)
            
            ScrollView {
                if let summary = viewModel.summaryResponse {
                    Spacer()
                    GradientCircleButton1(navigationPath: $navigationPath, destination: "summary", inputValue: summary.overallRating, emojiValue: summary.overallMood)
                    Text("Overall Mood: \(summary.overallMood)")
                    Text("Overall Rating: \(summary.overallRating)")
                    Text("Top 5 Mindful Things:")
                    ForEach(summary.top5MindfulStuff, id: \.self) { thing in
                        Text("- \(thing)")
                    }
                    Text("Recap:")
                    Text(summary.recap)
                } else {
                    Text("Loading summary...")
                }
            }
            
            Spacer()
            Button(action: {
                navigationPath.removeLast()
            }) {
                Text("your monthly")
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
                        .stroke(Color.white, lineWidth: 2)
                )
            }
            
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
                        .stroke(Color.white, lineWidth: 2)
                )
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            fetchSummary()
        }
    }
    
    private func fetchSummary() {
        let currentYear = Calendar.current.component(.year, from: Date())
        let filteredEntries = entries.filter { entry in
            let entryYear = Calendar.current.component(.year, from: entry.date ?? Date())
            return entryYear == currentYear
        }
        
        let message = filteredEntries.map { entry in
            "\(entry.summary1 ?? ""), \(entry.summary2 ?? ""), \(entry.summary3 ?? "")"
        }.joined(separator: "\n\n")
        
        viewModel.fetchSummary(message: message)
    }
}
