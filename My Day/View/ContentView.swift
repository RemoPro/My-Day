//
//  ContentView.swift
//  My Day
//
//  Created by Remo Prozzillo on 23.10.2024.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    
    // Database through variable…
    @Environment(\.modelContext) private var modelContext
    
    // search through the database for the values
    @Query private var event: [Event]
    //🔴 @Query(sort: \Event.startTime) // sort after time beginning
    
    // showing the "add new" sheet
    @State private var showSheet: Bool = false
    
    @State private var title: String = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var body: some View {
        NavigationSplitView{
            
            // If nothing is saved show it
            if event.isEmpty {
                ContentUnavailableView("Keine Einträge vorhanden…", systemImage: "circle.slash")
            }
            
            List{
                
                // repeat with each entry
                ForEach(event) { event in
                    
                    VStack(alignment: .leading) {
                        Text(event.title)
                            .bold()
                        HStack{
                            // Time isn't a string and has to be maked
                            Text(event.startTime.formatted(date: .omitted, time: .shortened))
                            Text("–")
                            Text(event.endTime.formatted(date: .omitted, time: .shortened))
                        }
                    }
                    
                    
                }
                .onDelete(perform: deleteItems) // Löscchen ermöglichen
                
            } // List
            .navigationTitle("Tagesplan")
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
                    Button{
                        showSheet = true
                        
                    } label: {
                        Image(systemName: "plus")
                    }
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
