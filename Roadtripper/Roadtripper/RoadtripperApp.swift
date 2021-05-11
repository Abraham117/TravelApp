//
//  RoadtripperApp.swift
//  Roadtripper
//
//  Created by Abraham Aldana on 4/28/21.
//

import SwiftUI

@main
struct RoadtripperApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(modelData)
        }
    }
}
