//
//  AddEventView.swift
//  My Day
//
//  Created by Remo Prozzillo on 24.10.2024.
//

// The View for adding a new event (for the user)

import SwiftUI
import SwiftData

struct AddEventView: View {
    // Database through variable…
    @Environment(\.modelContext) var modelContext
    
    /*// Detecting Apperance (Light/Dark)
     @Environment(\.colorScheme) var colorScheme
     func colorSchemeSetting() -> Color {
     if colorScheme == .light {
     return .white
     } else {
     return .black
     }
     }*/
    
    // Acessing the variable from the ContentView for closing this View with a Button
    @Binding var showSheet: Bool
    
    // Generating the variables for saving them into the database
    @State private var title: String = ""
    //@State private var nameDescription: String = ""
    
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    //@State private var eventColor: Color = .white // opposite of .primary
    @State private var eventBackgroundColor: Color = .gray
    
    @State private var eventFontColor: Color = .primary
    
    var body: some View {
        // For adding a new event
        
        List {
            // Preview of the field
            Section{
                HStack {
                    // Left: time, aligment on right because 8:00 is narrower than 10:00
                    //  8:00
                    //     8
                    // 10:00
                    VStack(alignment: .trailing) {
                        // Start time
                        Text(startTime.formatted(date: .omitted, time: .shortened))
                        
                        // Difference
                        let interval = endTime.timeIntervalSince(startTime)
                        Text(interval.formattedTime)
                            .font(.caption)
                        
                        // End time
                        Text(endTime.formatted(date: .omitted, time: .shortened))
                    }
                    
                    VStack(alignment: .leading) {
                        // Title
                        if title.isEmpty == false {
                            Text(title)
                                .font(.system(.title2, weight: .bold))
                        } else if title.isEmpty == true {
                            Text("exampleTitle")
                                .font(.system(.title2, weight: .bold))
                        }
                        /*
                         // Description
                         if nameDescription.isEmpty == false {
                         Text(nameDescription)
                         } else if nameDescription.isEmpty == true {
                         Text("Beschreibung")
                         }*/
                    }
                } // HStack
                
                // Text Color
                .foregroundStyle(Color.init(hex: "\(eventFontColor.toHex())"))
                // Background Color
                .listRowBackground(Color.init(hex: "\(eventBackgroundColor.toHex())"))
            } header: {
                Text("exampleEventHeader")
            }
            
            Section{
                TextField("exampleTitle", text: $title)
                //TextField("Beschreibung", text: $nameDescription)
                
                Group{
                    DatePicker("eventStart",
                               selection: $startTime,
                               displayedComponents: .hourAndMinute)
                    .onChange(of: startTime) { oldValue, newValue in
                        print("Old start time: \(startTime)")
                        print("New start time: \(startTime)")
                    }
                    DatePicker("eventEnd",
                               selection: $endTime,
                               displayedComponents: .hourAndMinute)
                    .onChange(of: endTime) { oldValue, newValue in
                        print("Old end time: \(endTime)")
                        print("New end time: \(endTime)")
                    }
                }
                .datePickerStyle(.compact)
                //.listRowSeparator(.hidden, edges: .bottom)
            } // End Section adding details
            
            // Colors
            Section{
                // The ColorPicker generates a color that I need to convert to a string
                ColorPicker("eventColor",
                            selection: $eventBackgroundColor,
                            supportsOpacity: false)
                .onChange(of: eventBackgroundColor) { oldValue, newValue in
                    print("Old background color: \(oldValue.toHex())")
                    print("New background color: \(newValue.toHex())")
                    // color, toHex Function
                }
                
                ColorPicker("eventTextColor",
                            selection: $eventFontColor,
                            supportsOpacity: false)
                .onChange(of: eventFontColor) { oldValue, newValue in
                    print("Old text color: \(oldValue.toHex())")
                    print("New text color: \(newValue.toHex())")
                    // color, toHex Function
                }
            } header: {
                Text("colorHeader")
            }
            
            // Debug
            /*Section{
             Text("eventColor: \(eventBackgroundColor.toHex())")
             .foregroundStyle(Color.init(eventBackgroundColor))
             Text("eventFontColor: \(eventFontColor.toHex())")
             .foregroundStyle(Color.init(eventFontColor))
             } header: {
             Text("Debug")
             }*/
            
            Button{
                // create new item, key in the database and variable
                let newEvent = Event(
                    title: title,
                    //nameDescription: nameDescription,
                    startTime: startTime,
                    endTime: endTime,
                    eventBackgroundColor: eventBackgroundColor.toHex(),
                    eventFontColor: eventFontColor.toHex()
                )
                // for the database it must be a string
                //  - so converting the color to string
                
                // put into database
                modelContext.insert(newEvent)
                print("Neues Event gespeichert")
                
                // close the sheet
                showSheet = false
            } label: {
                
                // if the user didn't wrote an title yet tint the button grey
                if title.isEmpty {
                    Label("buttonAddEvent", systemImage: "plus")
                    .foregroundStyle(.secondary)
                } else if title.isEmpty == false { // title provided
                    Label("buttonAddEvent", systemImage: "plus")
                }
            }
            .disabled(title.isEmpty)
            
            //.navigationTitle("Neues Event")
        } // List
        /*#if os(macOS)
         .frame(minHeight: 500, maxHeight: .infinity)
         #endif*/
    } // View
}

#Preview {
  AddEventView(showSheet: .constant(false)) // to make the Preview work
}
