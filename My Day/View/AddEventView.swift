//
//  AddEventView.swift
//  My Day
//
//  Created by Remo Prozzillo on 24.10.2024.
//

import SwiftUI
import SwiftData

struct Colors: Identifiable {
    let id = UUID()
    let color: String
}

struct AddEventView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var showSheet: Bool
    
    @State private var title: String = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var eventColor: String = ""
    // Colors for the buttons
    @State private var array: [Colors] = [
        Colors(color: "cyan"), //🩵
        Colors(color: "teal"), //🩵
        Colors(color: "mint"), //🩵
        Colors(color: "blue"), //🔵
        Colors(color: "green"), //🟢
        Colors(color: "yellow"), //🟡
        Colors(color: "orange"), //🟠
        Colors(color: "red"), //🔴
        Colors(color: "pink"), //🩷
        Colors(color: "purple"), //🟣
        Colors(color: "indigo"), //🔵
        Colors(color: "brown"), //🟤
        Colors(color: "gray"), //🩶
        Colors(color: "black"), //⚫️
        Colors(color: "white"), //⚪️
    ]
    
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
                    
                    //Text("Color…")
                    
                    /*ColorPicker("Farbe",
                                selection: $color,
                                supportsOpacity: false)*/
                } // End Section adding details
                
                Section{
                    // using ColorPicker with SwiftData isn't possible so i need to use a trick with buttons and color to string
                    Text("Color")
                    
                    Grid{
                        ForEach(array) { color in
                            Button(action: {
                                eventColor = ".\(color.color)"
                            }){
                                Color.blue // color.color or eventColor, it only must display the same color
                                // 🔴 But now the String needs to be changed to a color
                                    .frame(width: 100, height: 50)
                            }
                        } // ForEach
                    }
                } header: {
                    Text("Color")
                }
                
                Button{
                    // create new item, key in the database and variable
                    let newEvent = Event(title: title, startTime: startTime, endTime: endTime, eventColor: eventColor)
                    
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
