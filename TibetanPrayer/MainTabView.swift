//
//  MainTabView.swift
//  TibetanPrayer
//
//  Created by Kunchok Tashi on 2025-02-03.
//
import SwiftUI

struct AdaptivePrayerView: View {
    @StateObject private var viewModel = PrayerViewModel()
    @State private var selectedPrayer: Prayer?
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        if horizontalSizeClass == .compact {
            // iPhone: Use NavigationStack
            NavigationStack {
                List(viewModel.prayers) { prayer in
                    NavigationLink(destination: PrayerDetailView(prayer: prayer)) {
                        PrayerListItemView(index: viewModel.prayers.firstIndex(where: { $0.id == prayer.id }) ?? 0, prayer: prayer)
                    }
                }
                .navigationTitle("Tibetan Prayer")
            }
        } else {
            // iPad & Mac: Use NavigationSplitView
            NavigationSplitView {
                List(viewModel.prayers.enumerated().map { $0 }, id: \.element.id) { index, prayer in
                    PrayerListItemView(index: index, prayer: prayer)
                        .onTapGesture {
                            selectedPrayer = prayer
                        }
                }
                .navigationTitle("Tibetan Prayer")
                .listStyle(SidebarListStyle())
            } detail: {
                if let prayer = selectedPrayer {
                    PrayerDetailView(prayer: prayer)
                } else {
                    ContentUnavailableView("Select a Prayer",
                        systemImage: "book.closed.fill",
                        description: Text("Choose a prayer from the list to view its details"))
                }
            }
        }
    }
}

