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
    ///@State private var title: String = ""
    //@State private var nameDescription: String = ""
    
    ///@State private var startTime = Date()
    ///@State private var endTime = Date()
    @State private var event = Event()
    
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
                        Text(event.startTime.formatted(date: .omitted, time: .shortened))
                        
                        // Difference
                        let interval = event.endTime.timeIntervalSince(event.startTime)
                        Text(interval.formattedTime)
                            .font(.caption)
                        
                        // End time
                        Text(event.endTime.formatted(date: .omitted, time: .shortened))
                    }
                    
                    VStack(alignment: .leading) {
                        // Title
                        if event.title.isEmpty == false {
                            Text(event.title)
                                .font(.system(.title2, weight: .bold))
                        } else if event.title.isEmpty == true {
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
                TextField("exampleTitle", text: $event.title)
                //TextField("Beschreibung", text: $nameDescription)
                
                Group{
                    DatePicker("eventStart",
                               selection: $event.startTime,
                               displayedComponents: .hourAndMinute)
                    .onChange(of: event.startTime) { oldValue, newValue in
                        print("Old start time: \(event.startTime)")
                        print("New start time: \(event.startTime)")
                    }
                    DatePicker("eventEnd",
                               selection: $event.endTime,
                               displayedComponents: .hourAndMinute)
                    .onChange(of: event.endTime) { oldValue, newValue in
                        print("Old end time: \(event.endTime)")
                        print("New end time: \(event.endTime)")
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
                    event.eventBackgroundColor = newValue.toHex()
                }
                
                ColorPicker("eventTextColor",
                            selection: $eventFontColor,
                            supportsOpacity: false)
                .onChange(of: eventFontColor) { _, newValue in
                    event.eventFontColor = newValue.toHex()
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
//                let newEvent = Event(
//                    title: event.title,
//                    //nameDescription: nameDescription,
//                    startTime: event.startTime,
//                    endTime: event.endTime,
//                    eventBackgroundColor: eventBackgroundColor.toHex(),
//                    eventFontColor: eventFontColor.toHex()
//                )
                // for the database it must be a string
                //  - so converting the color to string
                
                // put into database
                modelContext.insert(event)
                print("Neues Event gespeichert")
                
                // close the sheet
                showSheet = false
            } label: {
                
                // if the user didn't wrote an title yet tint the button grey
                if event.title.isEmpty {
                    Label("buttonAddEvent", systemImage: "plus")
                    .foregroundStyle(.secondary)
                } else if event.title.isEmpty == false { // title provided
                    Label("buttonAddEvent", systemImage: "plus")
                }
            }
            .disabled(event.title.isEmpty)
            
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
