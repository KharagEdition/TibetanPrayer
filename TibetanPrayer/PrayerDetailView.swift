//
//  PrayerDetailView.swift
//  TibetanPrayer
//
//  Created by Kunchok Tashi on 2025-02-03.
//
import SwiftUI
struct PrayerDetailView: View {
    @StateObject private var viewModel = PrayerViewModel()
    let prayer: Prayer
    @State private var count: Int
    
    init(prayer: Prayer) {
        self.prayer = prayer
        _count = State(initialValue: prayer.count ?? 0)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Image Header
                Image("bhudha")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                
                // Title
                Text(prayer.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Counter
//                PrayerCounterView(
//                    prayer: prayer,
//                    count: $count,
//                    viewModel: viewModel
//                )
//                .frame(maxWidth: .infinity, alignment: .center)
                
                // Content
                Text(prayer.content)
                    .font(.title2)
                    .lineSpacing(10)
                    .padding(.vertical)
            }
            .padding()
            .frame(maxWidth: 800) // Limit content width on large screens
            .frame(maxWidth: .infinity) // Center content
        }
    }
}

