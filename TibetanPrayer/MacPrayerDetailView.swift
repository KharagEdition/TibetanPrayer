//
//  MacPrayerDetailView.swift
//  TibetanPrayer
//
//  Created by Kunchok Tashi on 2025-02-04.
//
import SwiftUI
struct MacPrayerDetailView: View {
    let prayer: Prayer
    @StateObject private var viewModel = PrayerViewModel()
    @State private var count: Int
    
    init(prayer: Prayer) {
        self.prayer = prayer
        _count = State(initialValue: prayer.count ?? 0)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
             
                
                Text(prayer.title)
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top).textSelection(.enabled)
                
                Text(prayer.content)
                    .font(.system(size: 24))
                    .lineSpacing(12).textSelection(.enabled)
                
                // Counter
//                HStack {
//                    Spacer()
//                    VStack {
//                        Text("\(count)")
//                            .font(.system(size: 36, weight: .bold))
//                        Text("Times Recited")
//                            .font(.headline)
//                    }
//                    Spacer()
//                }
//                .padding()
            }
            .padding(30)
        }
    }
}
