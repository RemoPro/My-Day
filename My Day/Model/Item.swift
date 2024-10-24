//
//  Item.swift
//  My Day
//
//  Created by Remo Prozzillo on 23.10.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var id: UUID
    var title: String
    var startTime: Date = Date()
    var endTime: Date = Date()

  init(
    id: UUID = UUID(), //default value in init
    title: String,
    startTime: Date,
    endTime: Date = Date()
  ) {
    self.id = id
    self.title = title
    self.startTime = startTime
    self.startTime = endTime
    }
}
