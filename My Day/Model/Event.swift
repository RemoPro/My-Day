//
//  Event.swift
//  My Day
//
//  Created by Remo Prozzillo on 23.10.2024.
//

// Defining the variables that should be saved in to the database

import Foundation
import SwiftData
import SwiftUI

@Model
final class Event {
    var id: UUID // SwiftUI needs an unique ID for each row
    var title: String
    //var nameDescription: String
    var startTime: Date = Date()
    var endTime: Date = Date()
    
    var eventBackgroundColorString: String // not ideal to use a String for color but SwiftData doesn't support colors
    var eventFontColorString: String

    /// Computed property with a setter to enable us to use this color as a Binding in SwiftUI.
    var eventBackgroundColor: Color {
        get {
            Color(hex: eventBackgroundColorString)
        }
        set {
          eventBackgroundColorString = newValue.toHex()
        }
    }

  //TODO: ASSIGNMENT: add another computed property to be able to use eventFontColor directly in SwiftUI

    init(
        id: UUID = UUID(),
        title: String = "",
        //nameDescription: String,
        startTime: Date = Date.now,
        endTime: Date = Date.now,
        
        eventBackgroundColor: String = Color.secondary.toHex(),
        eventFontColor: String = Color.primary.toHex()
    ) {
        self.id = id
        self.title = title
        //self.nameDescription = nameDescription
        self.startTime = startTime
        self.startTime = endTime
        
        self.eventBackgroundColorString = eventBackgroundColor
        self.eventFontColorString = eventFontColor
    }
}
