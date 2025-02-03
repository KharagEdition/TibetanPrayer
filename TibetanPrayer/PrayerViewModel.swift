//
//  PrayerViewModel.swift
//  TibetanPrayer
//
//  Created by Kunchok Tashi on 2025-02-03.
//
import SwiftUI
import CoreData

class PrayerViewModel: ObservableObject {
    @Published var prayers: [Prayer] = []
    @Published var favoritePrayers: [Prayer] = []
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
        fetchPrayers()
    }
    
    func fetchPrayers() {
        let request: NSFetchRequest<PrayerEntity> = PrayerEntity.fetchRequest()
          do {
              let fetchedPrayers = try context.fetch(request)
              
              prayers = fetchedPrayers.compactMap { entity in
                  // Only create a Prayer if the id is non-zero
                  entity.id != 0 ? Prayer(
                      id: Int(entity.id),
                      title: entity.title ?? "",
                      content: entity.content ?? "",
                      imageUrl: entity.imageUrl,
                      isFavourite: entity.isFavourite,
                      count: Int(entity.count),
                      isDownloaded: entity.isDownloaded,
                      audioPath: entity.audioPath,
                      downloadUrl: entity.downloadUrl ?? ""
                  ) : nil
              }
              
              favoritePrayers = prayers.filter { $0.isFavourite }
          } catch {
              print("Error fetching prayers: \(error)")
          }
    }
    
    func addPrayer(_ prayer: Prayer) {
        let newPrayer = PrayerEntity(context: context)
        newPrayer.id = Int64.random(in: 1...Int64.max)
        newPrayer.title = prayer.title
        newPrayer.content = prayer.content
        newPrayer.imageUrl = prayer.imageUrl
        newPrayer.isFavourite = prayer.isFavourite
        newPrayer.count = Int64(prayer.count ?? 0)
        newPrayer.isDownloaded = prayer.isDownloaded
        newPrayer.audioPath = prayer.audioPath
        newPrayer.downloadUrl = prayer.downloadUrl
        
        do {
            try context.save()
            fetchPrayers()
        } catch {
            print("Error saving prayer: \(error)")
        }
    }
    
    func toggleFavorite(_ prayer: Prayer) {
        guard let index = prayers.firstIndex(where: { $0.id == prayer.id }) else { return }
        
        let request: NSFetchRequest<PrayerEntity> = PrayerEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", prayer.id ?? 0)
        
        do {
            let fetchedPrayers = try context.fetch(request)
            if let prayerEntity = fetchedPrayers.first {
                prayerEntity.isFavourite.toggle()
                try context.save()
                fetchPrayers()
            }
        } catch {
            print("Error toggling favorite: \(error)")
        }
    }
    
    func updatePrayer(_ prayer: Prayer) {
        guard let id = prayer.id else { return }
        
        let request: NSFetchRequest<PrayerEntity> = PrayerEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let fetchedPrayers = try context.fetch(request)
            if let prayerEntity = fetchedPrayers.first {
                // Update the count in the Core Data entity
                prayerEntity.count = Int64(prayer.count ?? 0)
                
                // Save the context to persist the changes
                try context.save()
                
                // Refetch to ensure UI is updated with the latest data
                fetchPrayers()
            }
        } catch {
            print("Error updating prayer count: \(error)")
        }
    }
}
