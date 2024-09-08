//
//  HomeView.swift
//  gratify
//
//  Created by Daniel Kim on 4/14/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var navigationPath = NavigationPath()
    @State private var errorMessage: String?
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            
            VStack(spacing: 20) {
                Text("GRATIFY")
                    .font(Font.custom("Futura-Medium", size: 60))
                
                GradientCircleButton(navigationPath: $navigationPath, destination: "monthly", inputValue: 3, emojiValue: 1)
                Spacer()

                RainbowButton(title: "Rate Your Day", destination: "rate", navigationPath: $navigationPath, viewModel: viewModel)
                
                RainbowButton(title: "View All Entries", destination: "entries", navigationPath: $navigationPath, viewModel: viewModel)
                                
                RainbowButton(title: "Go to Settings", destination: "settings", navigationPath: $navigationPath, viewModel: viewModel)
                
                RainbowButton(title: "Go to Tutorial", destination: "tutorial", navigationPath: $navigationPath, viewModel: viewModel)
            }
            .navigationDestination(for: String.self) { route in
                switch route {
                case "rate":
                    RatingView1(navigationPath: $navigationPath, viewModel: viewModel)
                case "details":
                    RatingView2(dailyEntry: $viewModel.dailyEntry, navigationPath: $navigationPath, viewModel: viewModel)
                case "entries":
                    EntriesView(navigationPath: $navigationPath, viewModel: viewModel)
                case "settings":
                    SettingsView(navigationPath: $navigationPath)
                case "tutorial":
                    TutorialView(navigationPath: $navigationPath)
                default:
                    EmptyView()
                }
            }
        }
    }
}

struct RainbowButton: View {
    var title: String
    var destination: String
    var navigationPath: Binding<NavigationPath>
    var viewModel: ViewModel
    
    var body: some View {
        NavigationLink(value: destination) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .red]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 2
                        )
                )
        }
    }
}


struct GradientCircleButton<Destination: Hashable>: View {
    var navigationPath: Binding<NavigationPath>
    var destination: Destination
    var inputValue: Int
    var emojiValue: Int
    @State private var animateGradient = false
        
        var body: some View {
            Button(action: {
                navigationPath.wrappedValue.append(destination)
            }) {
                Circle()
                    .fill(gradientColor(for: inputValue))
                    .onAppear {
                        withAnimation(Animation.linear(duration: 3.0).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
                    .frame(width: 250, height: 250)
                    .overlay(Circle()
                            .stroke(Color.black, lineWidth: 4))
                    .overlay(
                        Text(emoji(for: emojiValue))
                            .font(.system(size: 40))
                    )
                    
            
            }
        }
        
        private func emoji(for value: Int) -> String {
            switch value {
            case 1:
                return "😢"
            case 2:
                return "😔"
            case 3:
                return "😐"
            case 4:
                return "🙂"
            case 5:
                return "😊"
            case 6:
                return "😄"
            case 7:
                return "😁"
            default:
                return "😐"
            }
        }
        
    
    private func gradientColor(for value: Int) -> LinearGradient {
        switch value {
        case 1:
            return LinearGradient(
                gradient: Gradient(colors: [.purple, .orange]),
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
        case 2...4:
            return LinearGradient(
                gradient: Gradient(colors: [.orange, Color(red: 0.0, green: 0.5, blue: 1.0)]),
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
        case 5...7:
            return LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.0, green: 0.5, blue: 1.0), Color(red: 0.0, green: 0.5, blue: 1.0)]),
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
        case 8:
            return LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.2), Color(red: 0.0, green: 0.3, blue: 0.0)]),
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
        case 9:
            return LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.0, green: 0.3, blue: 0.0), .blue, .black]),
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
        default:
            return LinearGradient(
                gradient: Gradient(colors: [.purple, .orange]),
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
        }
    }
}

#Preview {
    HomeView()
}
