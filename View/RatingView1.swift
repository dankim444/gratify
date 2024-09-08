//
//  RatingView1.swift
//  gratify
//
//  Created by Sam on 4/14/24.
//

import Foundation
import SwiftUI

struct RatingView1: View {
    @Binding var navigationPath: NavigationPath
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            ForEach(1...7, id: \.self) { score in
                Button("\(score)") {
                    viewModel.dailyEntry.score = score
                    navigationPath.append("details") // Append the route for RatingView2
                }
            }
        }
        .navigationBarTitle("Rate Your Day")
    }
}
