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
            Spacer()
            Spacer()
            HStack {
                Text("How was your day?")
                    .font(Font.custom("Futura-Medium", size: 30))
            }
            Spacer()
            
            Text("Better")
                .font(Font.custom("GillSans", size: 18))
            ForEach((1...7).reversed(), id: \.self) { score in
                Button(action: {
                    viewModel.createNewDailyEntry()
                    viewModel.dailyEntry?.rating = Int16(score)
                    navigationPath.append("details")
                }) {
                    Text("\(score)")
                        .fontWeight(.semibold)
                        .frame(width: 200, height: 28)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
//                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                        .background(.black)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
            }
            Text("Worse")
                .font(Font.custom("GillSans", size: 18))
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    RatingView1(navigationPath: .constant(NavigationPath()), viewModel: ViewModel())
}
