//
//  ContentView.swift
//  My Day
//
//  Created by Remo Prozzillo on 23.10.2024.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    
    // Datenbank per Variabel ansprechbar machen
    @Environment(\.modelContext) private var modelContext
    
    // Datenbank durchsuchen und das anzeigen der Werte ermöglichen
    @Query private var items: [Item]
    
    // Damit das Sheet für neue hinzufügen gezeigt werden kann
    ///@State private var showSheet = false
    @State private var showSheet: Bool = false
    
    @State private var title: String = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var body: some View {
        NavigationSplitView{
            
            // Wenn die Datenbank leer ist es zeigen
            if items.isEmpty {
                ContentUnavailableView("Keine Einträge vorhanden…", systemImage: "cirle.slash")
            }
            
            // Liste der Einträge
            List{
                
                // Mit jedem Eintrag wiederholen
                ForEach(items) { item in
                    NavigationLink {
                        // Öffnet es als neue View
                        Text("Fach \(item.title)")
                    } label: {
                        // Was zu sehen ist
                        VStack{
                            Text(item.title)
                                .bold()
                            HStack{
                                // Die Zeiten sind nicht Text, darum maskieren in einem String
                                Text("\(item.startTime)") +
                                Text("+") +
                                Text("\(item.endTime)")
                            }
                        }
                        
                    } // label List Ende
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
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
}
