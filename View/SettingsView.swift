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
    
    var body: some View {
        VStack {
            Text("settings")
            // Settings content here
            Button(action: {
                navigationPath = NavigationPath()
            }) {
                Image(systemName: "homekit")
                    .padding()
                    .background(.purple)
                    .cornerRadius(5)
                    .foregroundStyle(.white)
            }
        }
    }
}
