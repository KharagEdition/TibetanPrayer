//
//  Prayer.swift
//  TibetanPrayer
//
//  Created by Kunchok Tashi on 2025-02-03.
//

import Foundation
import SwiftUI

struct Prayer: Identifiable, Codable,Hashable {
    var id: Int?
    var title: String
    var content: String
    var imageUrl: String?
    var isFavourite: Bool=false
    var count: Int?
    var isDownloaded: Bool=false
    var audioPath: String?=""
    var downloadUrl: String=""
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
           hasher.combine(title)
       }
       
       static func == (lhs: Prayer, rhs: Prayer) -> Bool {
           return lhs.id == rhs.id && lhs.title == rhs.title
       }
}
