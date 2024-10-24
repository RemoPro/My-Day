//
//  AddEventView.swift
//  My Day
//
//  Created by Remo Prozzillo on 24.10.2024.
//

import SwiftUI
import SwiftData

struct AddEventView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var showSheet: Bool
    
    @State private var title: String = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    // 🔴 @State private var eventColor: Color = Color
    
    var body: some View {
        // For adding a new event
        NavigationSplitView{
            List {
                Section{
                    TextField("Titel", text: $title)
                    
                    Group{
                        DatePicker("Start",
                                   selection: $startTime,
                                   displayedComponents: .hourAndMinute)
                        
                        DatePicker("Ende",
                                   selection: $endTime,
                                   displayedComponents: .hourAndMinute)
                    }
                    .datePickerStyle(.compact)
                    
                    /*ColorPicker("Farbe",
                                selection: $color,
                                supportsOpacity: false)*/
                } // End Section adding details
                
                Button{
                    // create new item
                    let newEvent = Event(title: title, startTime: startTime, endTime: endTime)
                    
                    // put into database
                    modelContext.insert(newEvent)
                    print("Neues Event gespeichert")
                    
                    // close the sheet
                    showSheet = false
                } label: {
                    Label("Hinzufügen", systemImage: "plus")
                }
                
            } // List
            .navigationTitle("Neues Event")
        } detail: {
            
        } // NavigationSplitView
        
    } // View
}

#Preview {
  AddEventView(showSheet: .constant(false)) // to make the Preview work
}
