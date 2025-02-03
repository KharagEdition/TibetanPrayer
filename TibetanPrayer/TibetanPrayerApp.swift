//
//  TibetanPrayerApp.swift
//  TibetanPrayer
//
//  Created by Kunchok Tashi on 2025-02-03.
//

import SwiftUI

@main
struct PrayerApp: App {
    // Add this initialization
    init() {
        // Initialize prayers when app first launches
        AppInitializer.shared.initializePrayersIfNeeded()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView() // Replace ContentView with your main tab view
                .environment(\.managedObjectContext,
                    PersistenceController.shared.container.viewContext)
        }
    }
}
