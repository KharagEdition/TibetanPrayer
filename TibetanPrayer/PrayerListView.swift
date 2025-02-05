//
//  PrayerListView.swift
//  TibetanPrayer
//
//  Created by Kunchok Tashi on 2025-02-03.
//
import SwiftUI
struct PrayerListItemView: View {
    let index: Int
    let prayer: Prayer
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(getIndex(index + 1)). \(prayer.title)")
                .font(.headline)
            Text(prayer.content)
                .font(.subheadline)
                .lineLimit(2)
                .lineSpacing(2)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    func getIndex(_ index: Int) -> String {
        let tibetanDigits: [Character: Character] = [
            "0": "༠", "1": "༡", "2": "༢", "3": "༣", "4": "༤",
            "5": "༥", "6": "༦", "7": "༧", "8": "༨", "9": "༩"
        ]
        let indexString = String(index)
        return indexString.compactMap { tibetanDigits[$0] }
            .map { String($0) }
            .joined()
    }
}
