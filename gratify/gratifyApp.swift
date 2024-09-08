//
//  gratifyApp.swift
//  gratify
//
//  Created by Daniel Kim on 9/8/24.
//

import SwiftUI

@main
struct gratifyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.managedContext)
        }
    }
}
