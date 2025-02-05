//
//  TibetanPrayerApp.swift
//  TibetanPrayer
//
//  Created by Kunchok Tashi on 2025-02-03.
//
import SwiftUI

@main
struct PrayerApp: App {
    init() {
        AppInitializer.shared.initializePrayersIfNeeded()
    }
    
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            AdaptivePrayerView()
                .environment(\.managedObjectContext,
                    PersistenceController.shared.container.viewContext)
            #else
            MacMainView()
                .environment(\.managedObjectContext,
                    PersistenceController.shared.container.viewContext)
            #endif
        }
    }
}
