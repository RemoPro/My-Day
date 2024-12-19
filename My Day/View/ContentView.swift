//
//  ContentView.swift
//  My Day
//
//  Created by Remo Prozzillo on 23.10.2024.
//

// The View that the app displays when opened. It shows either nothing or the events.

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // Database through variable…
    @Environment(\.modelContext) private var modelContext
    
    // search through the database for the values and sort after the beginning time
        @Query(sort: \Event.startTime) var event: [Event] // sort after time beginning
    
    // showing the "add new" sheet
    @State private var showSheet: Bool = false
    
    @State private var title: String = ""
    @State private var startTime = Date()
    @State private var endTime = Date()

    
    var body: some View {
        NavigationSplitView{
            
            // If nothing is saved show it
            if event.isEmpty {
                ContentUnavailableView("noEvents", systemImage: "circle.slash")
            }
            
            List{
                
                // repeat with each entry
                ForEach(event) { event in
                    
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
                            Text(event.title)
                                .font(.system(.title2, weight: .bold))
                            // Description
                            //Text(event.nameDescription)
                        }
                    } // HStack
                    
                    // Text Color
                    .foregroundStyle(Color.init(hex: "\(event.eventFontColor)")) // text color
                    // Background Color
                    .listRowBackground(Color.init(hex: "\(event.eventBackgroundColor)"))
                    
                } // ForEach
                .onDelete(perform: deleteItems) // enable deletion
                /*.swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        event.remove(at: index)
                    } label: {
                        Image(systemName: "trash")
                    }
                }*/
            } // List
            .navigationTitle("titleAppName")
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                // Knopf oben
                ToolbarItem {
                    Button("Add", systemImage: "plus") {
                        showSheet = true
                    }
                    .labelStyle(.iconOnly)
                    .sheet(isPresented: $showSheet) {
                        // Andere View öffnen
                        AddEventView(showSheet: $showSheet)
                    } // sheet
                } // ToolbarItem
            } // toolbar
        } detail: {
            Text("Select an item")
        } // NavigationSplitView
    } // View
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(event[index])
            }
        }
    }
}

#Preview {
  ContentView()
}
