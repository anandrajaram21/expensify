//
//  expensifyApp.swift
//  expensify
//
//  Created by Anand Rajaram on 21/04/25.
//

import SwiftUI
import SwiftData

@main
struct expensifyApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Person.self,
            Expense.self,
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
