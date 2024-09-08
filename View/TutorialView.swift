//
//  TutorialView.swift
//  gratify
//
//  Created by Sam on 4/14/24.
//

import Foundation
import SwiftUI

struct TutorialView: View {
    @Binding var navigationPath: NavigationPath
    @State private var inputValue = 1
    
    var body: some View {
        VStack {
            Text("GUIDE")
                .font(Font.custom("Futura-Medium", size: 40))
                .foregroundColor(Color.black)
            ScrollView {
                Spacer()
                GradientCircleButton1(navigationPath: $navigationPath, destination: "summary", inputValue: inputValue, emojiValue: 5)
                Spacer(minLength: 20)
                
                HStack {
                    Text("Life gets busy. We don't often take the time to stop, and reflect on our day-to-day. Yet, there's real science that gratitude contributes subtantially to our individual wellbeing and physical health. ")
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(width: 350, height: 100)
                
                HStack {
                    Text("We wanted to make it easier—not just to log \(Text("what").italic()) you're grateful for, but to reflect on \(Text("why").italic()) that's the case over long periods of time. Our app isn't your everyday Gratitude journal. It uses AI to analyze patterns in your gratitude, to provide you with useful insights. We made this app to help you live deliberately. Welcome to GRATIFY.")
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(width: 350, height: 180)

                
            
                HStack {
                    Text("The gradient displayed by the app changes from dark blues on some days, to orange on other days. While a darker blue gradient means your gratitude is more materialistic, a more orange gradient indicates that your gratitude is more experiential. The emoji displayed at the center is an indication of your overall mood over the past few days. Each day at 9PM, Gratify sends you a notification to rate your day, and journal about what you were grateful for. You can change the notification time in Settings.")
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(width: 350, height: 280)
            }
            Spacer()
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
            startInputValueCycle()
        }
    }
    
    private func startInputValueCycle() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            withAnimation {
                inputValue = (inputValue % 9) + 1
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }
}

#Preview {
    TutorialView(navigationPath: .constant(NavigationPath()))
}

