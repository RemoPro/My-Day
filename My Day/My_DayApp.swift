//
//  My_DayApp.swift
//  My Day
//
//  Created by Remo Prozzillo on 23.10.2024.
//

// This file is used when opening the app. It also creates the database model

import SwiftUI
import SwiftData

@main
struct My_DayApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Event.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
