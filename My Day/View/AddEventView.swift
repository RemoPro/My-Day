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

  var body: some View {
    // Felder für hinzufügen
    List {
      Text("Neues Event")

      TextField("Titel", text: $title)

      DatePicker("Start",
                 selection: $startTime,
                 displayedComponents: .hourAndMinute
      )
      .datePickerStyle(.compact)

      DatePicker("Ende",
                 selection: $endTime,
                 displayedComponents: .hourAndMinute
      )
      .datePickerStyle(.compact)

      Button{
        // Neues Objekt erstellen
        let newItem = Item(title: title, startTime: startTime, endTime: endTime)
        //let newItem = Event(event: title, startTime: startDate.formatted(.time), endTime: endTime.formatted(.time))

        // In die Datenbank tun
        modelContext.insert(newItem)
        print("Neues Event gespeichert")

        // Schliessen
        showSheet = false
      } label: {
        Label("Hinzufügen", systemImage: "plus")
      }
    }
  } // View
}

#Preview {
  AddEventView(showSheet: .constant(false)) // Damit es in der Preview geht
}

/*
 private func addItem() {
 withAnimation {

 let newItem = Event(event: "Fach", startTime: "12:00", endTime: "13:00")
 print("Neues Objekt erstellt")
 // 🔴 sollte ein Wähler sein als Sheet…


 modelContext.insert(newItem)
 print("In die Datenbank getan")
 }
 }
 */
