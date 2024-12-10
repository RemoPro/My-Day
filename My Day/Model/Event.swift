//
//  Event.swift
//  My Day
//
//  Created by Remo Prozzillo on 23.10.2024.
//

// Defining the variables that should be saved in to the database

import Foundation
import SwiftData

@Model
final class Event {
    var id: UUID // SwiftUI needs an unique ID for each row
    var title: String
    //var nameDescription: String
    var startTime: Date = Date()
    var endTime: Date = Date()
    
    var eventBackgroundColor: String // not ideal to use a String for color but SwiftData doesn't support colors
    var eventFontColor: String
    
    init(
        id: UUID = UUID(),
        title: String,
        //nameDescription: String,
        startTime: Date,
        endTime: Date = Date(),
        
        eventBackgroundColor: String,
        eventFontColor: String
    ) {
        self.id = id
        self.title = title
        //self.nameDescription = nameDescription
        self.startTime = startTime
        self.startTime = endTime
        
        self.eventBackgroundColor = eventBackgroundColor
        self.eventFontColor = eventFontColor
    }
}
