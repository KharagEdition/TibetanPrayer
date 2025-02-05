//
//  MacMainView.swift
//  TibetanPrayer
//
//  Created by Kunchok Tashi on 2025-02-04.
//

import SwiftUI
struct MacMainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedPrayer: Prayer?
    
    var body: some View {
        NavigationSplitView {
            // Sidebar
            List {
                Section("Categories") {
                    NavigationLink(destination: MacPrayerListView(selectedPrayer: $selectedPrayer)) {
                        Label("All Prayers", systemImage: "book.fill")
                    }
//                    NavigationLink(destination: EmptyView()) {
//                        Label("Favorites", systemImage: "heart.fill")
//                    }
                }
            }
            .navigationTitle("Tibetan Prayer")
            .listStyle(SidebarListStyle())
        } content: {
            MacPrayerListView(selectedPrayer: $selectedPrayer)
        } detail: {
            if let prayer = selectedPrayer {
                MacPrayerDetailView(prayer: prayer)
            } else {
                Text("Select a prayer")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
        }
        .navigationSplitViewStyle(.automatic)
    }
}
