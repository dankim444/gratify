//
//  MonthlyView.swift
//  gratify
//
//  Created by Daniel Kim on 4/22/24.
//

import Foundation
import SwiftUI

struct MonthlyView: View {
    @Binding var navigationPath: NavigationPath
    @ObservedObject var viewModel: ViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DayEntry.date, ascending: false)],
        animation: .default
    )
    private var entries: FetchedResults<DayEntry>
    
    var body: some View {
        VStack {
            Text("your monthly")
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
                        .padding()
                } else {
                    Text("Loading summary...")
                        .padding()
                }
            }
            
            Spacer()
            Button(action: {
                navigationPath.append("yearly")
            }) {
                Text("your yearly")
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
        let pastMonth = Date().addingTimeInterval(-30 * 24 * 60 * 60) // 30 days ago
        let recentEntries = entries.filter { $0.date ?? Date() >= pastMonth }
        let limitedEntries = Array(recentEntries.prefix(30))
        
        let message = limitedEntries.map { entry in
            "\(entry.summary1 ?? ""), \(entry.summary2 ?? ""), \(entry.summary3 ?? "")"
        }.joined(separator: "\n\n")
        
        viewModel.fetchSummary(message: message)
    }
}
