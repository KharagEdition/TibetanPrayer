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
            VStack(alignment: .leading, spacing: 10) {
                // Image Header
                Image("bhudha")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .cornerRadius(15)
                
                // Prayer Content with Counter
                VStack(alignment: .leading, spacing: 5) {
                    Text(prayer.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Advanced Counter
//                    HStack {
//                        Spacer()
//                        PrayerCounterView(
//                            prayer: prayer,
//                            count: $count,
//                            viewModel: viewModel
//                        )
//                        Spacer()
//                    }
                    
                    Text(prayer.content)
                        .font(Font.title2)
                        .lineSpacing(10).padding()
                }
                .padding(.horizontal)
            }.padding()
        }.padding()
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct PrayerCounterView: View {
    let prayer: Prayer
    @Binding var count: Int
    @ObservedObject var viewModel: PrayerViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: decrementCount) {
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.red)
            }
            
            VStack {
                Text("\(count)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
                Text("Times Recited")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Button(action: incrementCount) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
    
    private func incrementCount() {
        count += 1
        updatePrayerCount()
    }
    
    private func decrementCount() {
        if count > 0 {
            count -= 1
            updatePrayerCount()
        }
    }
    
    private func updatePrayerCount() {
        var updatedPrayer = prayer
        updatedPrayer.count = count
        viewModel.updatePrayer(updatedPrayer)
    }
}
