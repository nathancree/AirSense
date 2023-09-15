//
//  AirSenseApp.swift
//  AirSense
//
//  Created by Nathan Cree on 9/14/23.
//

import SwiftUI

@main
struct AirSenseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
