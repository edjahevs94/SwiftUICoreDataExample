//
//  CoreDataDemoApp.swift
//  CoreDataDemo
//
//  Created by EdgardVS on 15/09/22.
//

import SwiftUI

@main
struct CoreDataDemoApp: App {
    
    let persistenceController = PersistenceController.shared
    

    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
