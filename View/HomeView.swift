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
    @StateObject var viewModel = ViewModel()
    
    
    var body: some View {
        Spacer()
        Spacer()
        Spacer()
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 20) {
                Text("GRATIFY")
                    .font(Font.custom("Futura-Medium", size: 60))
                    .foregroundColor(Color.black)
                
                Spacer()
                GradientCircleButton(navigationPath: $navigationPath, destination: "summary", inputValue: 2, emojiValue: 1)
                Spacer()
                
                RainbowButton(title: "Rate Your Day", destination: "rate", navigationPath: $navigationPath, viewModel: viewModel)
                                
                RainbowButton(title: "Settings", destination: "settings", navigationPath: $navigationPath, viewModel: viewModel)
                
                RainbowButton(title: "Tutorial", destination: "tutorial", navigationPath: $navigationPath, viewModel: viewModel)
                
                RainbowButton(title: "Journal", destination: "all", navigationPath: $navigationPath, viewModel: viewModel)
                
                Spacer()
            
            }
//            .background(
//                LinearGradient(gradient: Gradient(colors: [Color(red: 245/255, green: 247/255, blue: 250/255), Color(red: 195/255, green: 207/255, blue: 226/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            )
            .navigationDestination(for: String.self) { route in
                switch route {
                case "rate":
                    RatingView1(navigationPath: $navigationPath, viewModel: viewModel)
                case "settings":
                    SettingsView(navigationPath: $navigationPath)
                case "tutorial":
                    TutorialView(navigationPath: $navigationPath)
                case "all":
                    EntriesView(navigationPath: $navigationPath /*viewModel: viewModel*/)
                case "yearly":
                    YearlyView(navigationPath: $navigationPath, viewModel: viewModel)
                case "details":
                    RatingView2(viewModel: viewModel, navigationPath: $navigationPath)
                case "summary":
                    MonthlyView(navigationPath: $navigationPath, viewModel:viewModel)
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
    
    @State private var animateGradient = false
    
    var body: some View {
        NavigationLink(value: destination) {
            Text(title)
                .fontWeight(.medium)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(.white)
                .cornerRadius(15)
                .shadow(radius: 3)
        }
        .padding(.horizontal, 70)
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
                    withAnimation(Animation.bouncy(duration: 4.5).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
                .frame(width: 250, height: 250)
                .overlay(Circle().stroke(Color.black, lineWidth: 4))
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
                gradient: Gradient(colors: [hexToColor(hex: "30cfd0"), hexToColor(hex: "330867")]),
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
        case 2:
            return LinearGradient(
                gradient: Gradient(colors: [hexToColor(hex: "5ee7df"), hexToColor(hex: "b490ca")]),
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
        case 3:
            return LinearGradient(
                gradient: Gradient(colors: [hexToColor(hex: "a8edea"), hexToColor(hex: "fed6e3")]),
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
        case 4:
            return LinearGradient(
                gradient: Gradient(colors: [hexToColor(hex: "f5f7fa"), hexToColor(hex: "c3cfe2")]),
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
        case 5:
            return LinearGradient(
                gradient: Gradient(colors: [hexToColor(hex: "ebbba7"), hexToColor(hex: "cfc7f8")]),
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
        case 6:
            return LinearGradient(
                gradient: Gradient(colors: [hexToColor(hex: "fccb90"), hexToColor(hex: "d57eeb")]),
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
        case 7:
            return LinearGradient(
                gradient: Gradient(colors: [hexToColor(hex: "fa709a"), hexToColor(hex: "fee140")]),
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
    
    private func hexToColor(hex: String) -> Color {
        var formattedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        formattedHex = formattedHex.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: formattedHex).scanHexInt64(&rgb) else { return Color(.black) }
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        return Color(red: red, green: green, blue: blue)
    }
}

#Preview {
    HomeView()
}
