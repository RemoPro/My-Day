//
//  Color+Extensions.swift
//  My Day
//
//  Created by Remo Prozzillo on 07.11.2024.
//

import SwiftUI
#if os(iOS) // 🔴 it needs UIKit but that only works in iOS
import UIKit
#endif

extension Color {
    
    // Color to Hex (In this app saved to a String)
    func toHex() -> String {
        guard let components = UIColor(self).cgColor.components else {
            return ""
        }
        
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        
        return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
    
    // Hex (Saved as a String) to Color
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
    
    /* // Other?
     init(hex: String) {
     let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
     var int: UInt64 = 0
     Scanner(string: hex).scanHexInt64(&int)
     let a, r, g, b: UInt64
     switch hex.count {
     case 3: // RGB (12-bit)
     (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
     case 6: // RGB (24-bit)
     (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
     case 8: // ARGB (32-bit)
     (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
     default:
     (a, r, g, b) = (1, 1, 1, 0)
     }
     
     self.init(
     .sRGB,
     red: Double(r) / 255,
     green: Double(g) / 255,
     blue:  Double(b) / 255,
     opacity: Double(a) / 255
     )
     }*/
}
