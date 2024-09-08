//
//  SettingsView.swift
//  gratify
//
//  Created by Sam on 4/14/24.
//

import Foundation

import SwiftUI
struct SettingsView: View {
    @Binding var navigationPath: NavigationPath
    @State private var showDeleteAlert = false
    @AppStorage("isScheduled") var isScheduled = true
        // Save the notification time set by user for daily reminder
    @AppStorage("notificationTimeString") var notificationTimeString = defaultNotificationTimeString()
    
    
    var body: some View {
        VStack {
                Spacer()
                Text("SETTINGS")
                    .font(Font.custom("Futura-Medium", size: 40))
                    .foregroundColor(Color.black)
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
            ScrollView {
                // The toggle if the user want to use daily reminder feature
                Spacer(minLength: 10)
                Toggle("Schedule Daily Reminder", isOn: $isScheduled)
                    .tint(.black)
                    .onChange(of: isScheduled) { isScheduled in
                        handleIsScheduledChange(isScheduled: isScheduled)
                    }
                    .padding(.horizontal, 40)
                
                
                // Show the date picker if the daily reminder feature is on
                if isScheduled {
                    DatePicker("", selection: Binding(
                        get: {
                            // Get the notification time schedule set by user
                            DateHelper.dateFormatter.date(from: notificationTimeString) ?? Date()
                        },
                        set: {
                            // On value set, change the notification time
                            notificationTimeString = DateHelper.dateFormatter.string(from: $0)
                            handleNotificationTimeChange()
                        }
                        // Only use hour and minute components, since this is a daily reminder
                    ), displayedComponents: .hourAndMinute)
                    // Use wheel date picker style, recommended by Apple
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                }
            }
        }
        VStack {
        }
        .navigationBarTitleDisplayMode(.inline)
        Spacer()
        Spacer(minLength: 150)
        Text("We will never share your data.")
        Button(action: {
            showDeleteAlert = true
        }) {
            Text("DELETE MY DATA")
            .fontWeight(.semibold)
            .frame(width: 200)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15)
            .shadow(radius: 10)
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 2)
            )
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete Data"),
                message: Text("Are you sure you want to delete your data?"),
                primaryButton: .destructive(Text("Delete")) {
                    print("Data deleted")
                },
                secondaryButton: .cancel()
            )
        }
        Spacer()
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
    
    .navigationBarBackButtonHidden(true)
        Spacer()
        Spacer()
        
        
        
    }
}

private func defaultNotificationTimeString() -> String {
    let defaultNotificationTime = DateComponents(hour: 21, minute: 0)
    let defaultNotificationDate = Calendar.current.date(from: defaultNotificationTime)!
    return DateHelper.dateFormatter.string(from: defaultNotificationDate)
}

private extension SettingsView {
    // Handle if the user turned on/off the daily reminder feature
    private func handleIsScheduledChange(isScheduled: Bool) {
        if isScheduled {
            NotificationManager.requestNotificationAuthorization()
            NotificationManager.scheduleNotification(notificationTimeString: notificationTimeString)
        } else {
            NotificationManager.cancelNotification()
        }
    }
    
    // Handle if the notification time changed from DatePicker
    private func handleNotificationTimeChange() {
        NotificationManager.cancelNotification()
        NotificationManager.requestNotificationAuthorization()
        NotificationManager.scheduleNotification(notificationTimeString: notificationTimeString)
    }
}

struct GradientCircleButton1<Destination: Hashable>: View {
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
        .disabled(true)
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
            return "🤩"
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
    SettingsView(navigationPath: .constant(NavigationPath()))
}

