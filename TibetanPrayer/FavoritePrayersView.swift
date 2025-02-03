//
//  FavoritePrayersView.swift
//  TibetanPrayer
//
//  Created by Kunchok Tashi on 2025-02-03.
//

import SwiftUI

struct FavoritePrayersView: View {
    @StateObject private var viewModel = PrayerViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.favoritePrayers) { prayer in
                NavigationLink(destination: PrayerDetailView(prayer: prayer)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prayer.title)
                                .font(.headline)
                            Text(prayer.content)
                                .font(.subheadline)
                                .lineLimit(2)
                        }
                    }
                }
            }
            .navigationTitle("Favorite Prayers")
        }
    }
}
