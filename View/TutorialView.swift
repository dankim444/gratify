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
    
    var body: some View {
        VStack {
            Text("tutorial")
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
