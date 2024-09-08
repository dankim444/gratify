//
//  gratifyApp.swift
//  gratify
//
//  Created by Daniel Kim on 9/8/24.
//

import SwiftUI

@main
struct gratifyApp: App {
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
