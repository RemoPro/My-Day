//
//  Event.swift
//  My Day
//
//  Created by Remo Prozzillo on 23.10.2024.
//

import Foundation
import SwiftData

@Model
final class Event {
    var id: UUID
    var title: String
    var startTime: Date = Date()
    var endTime: Date = Date()
    //🔴var eventColor: Color // Add a color to let the user pick from
    
    init(
        id: UUID = UUID(), //default value in init
        title: String,
        startTime: Date,
        endTime: Date = Date()
        //eventColor: Color
    ) {
        self.id = id
        self.title = title
        self.startTime = startTime
        self.startTime = endTime
        //self.eventColor = eventColor
    }
}
