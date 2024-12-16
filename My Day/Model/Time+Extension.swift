//
//  Time+Extension.swift
//  My Day
//
//  Created by Remo Prozzillo on 02.12.2024.
//

// Is used for showing the difference time between the start and end date

import Foundation

extension TimeInterval {
    // Converts to a string of type "hh:mm". 
    var formattedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        guard let formattedString = formatter.string(from: self)
        else { fatalError("Failed to format time interval.") }
        return formattedString
    }
}
