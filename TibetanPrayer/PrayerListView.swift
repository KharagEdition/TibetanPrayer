//
//  PrayerListView.swift
//  TibetanPrayer
//
//  Created by Kunchok Tashi on 2025-02-03.
//
import SwiftUI

struct PrayerListView: View {
    @StateObject private var viewModel = PrayerViewModel()
    @State private var selectedPrayer: Prayer?
    
    var body: some View {
        NavigationView {
            List(viewModel.prayers.enumerated().map { $0 }, id: \.element.id) { index, prayer in
                NavigationLink(destination: PrayerDetailView(prayer: prayer)) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(getIndex(index + 1)). \(prayer.title)") // Add the index before the title
                                .font(.title2)
                            Text(prayer.content)
                                .font(.title3)
                                .lineLimit(2)
                                .lineSpacing(2)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
            //            Image(systemName: prayer.isFavourite ? "heart.fill" : "heart")
            //                .foregroundColor(.red)
            //                .onTapGesture {
            //                    viewModel.toggleFavorite(prayer)
            //                }
                    }
                }
            }
            .navigationTitle("Tibetan Prayer")
            .listStyle(PlainListStyle())
        }
    }
    func getIndex(_ index: Int) -> String {
        let tibetanDigits: [Character: Character] = [
            "0": "༠", "1": "༡", "2": "༢", "3": "༣", "4": "༤",
                 "5": "༥", "6": "༦", "7": "༧", "8": "༨", "9": "༩"
        ]
        
        // Convert the integer index to a string
        let indexString = String(index)
        
        // Map each digit to its Arabic numeral
        let tibetanString = indexString.compactMap { tibetanDigits[$0] }.map { String($0) }.joined()
        
        return tibetanString
    }
}
