//
//  PersistenceControllerClass.swift
//  CoreDataDemo
//
//  Created by EdgardVS on 15/09/22.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    
    init() {
        container = NSPersistentContainer(name: "Product")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error.localizedDescription)")
            }
        }
    }
}
