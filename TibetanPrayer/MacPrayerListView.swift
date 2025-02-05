//
//  MacPrayerListView.swift
//  TibetanPrayer
//
//  Created by Kunchok Tashi on 2025-02-04.
//

import SwiftUI
import CoreData

struct MacPrayerListView: View {
    @StateObject private var viewModel: PrayerViewModel
    @Binding var selectedPrayer: Prayer?
    @State private var searchText = ""
    
    init(selectedPrayer: Binding<Prayer?>) {
        self._selectedPrayer = selectedPrayer
        // Initialize with shared context
        self._viewModel = StateObject(wrappedValue: PrayerViewModel(context: PersistenceController.shared.container.viewContext))
    }
    
    var filteredPrayers: [Prayer] {
        if searchText.isEmpty {
            return viewModel.prayers
        }
        return viewModel.prayers.filter { prayer in
            prayer.title.localizedCaseInsensitiveContains(searchText) ||
            prayer.content.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        List(selection: $selectedPrayer) {
            ForEach(Array(filteredPrayers.enumerated()), id: \.element.id) { index, prayer in
                PrayerRow(prayer: prayer, index: index)
                    .tag(prayer)  // Enable selection
                    .contentShape(Rectangle())  // Make entire row clickable
            }
        }
        .navigationTitle("Prayers")
        .searchable(text: $searchText, prompt: "Search prayers")
        .listStyle(InsetListStyle())
        .onAppear {
            viewModel.fetchPrayers()
        }
    }
}

// Separate view for each prayer row
struct PrayerRow: View {
    let prayer: Prayer
    let index: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(getIndex(index+1)). \(prayer.title)").textSelection(.enabled)
                .font(.headline)
            Text(prayer.content)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundColor(.secondary).textSelection(.enabled)
        }
        .padding(.vertical, 4)
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
