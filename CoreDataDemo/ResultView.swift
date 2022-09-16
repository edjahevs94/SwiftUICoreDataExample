//
//  ResultView.swift
//  CoreDataDemo
//
//  Created by EdgardVS on 15/09/22.
//

import SwiftUI
import CoreData

struct ResultView: View {
    var name: String
    var viewContext: NSManagedObjectContext
    @State var matches: [Product]?
    
    var body: some View {
        return VStack {
               List {
             
                   ForEach(matches ?? []) { match in
                       HStack {
                           Text(match.name ?? "Not found")
                           Spacer()
                           Text(match.quantity ?? "Not found")
                       }
                   }
               }
               .navigationTitle("Results")
              
           }
           .task {
               let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
               
               fetchRequest.entity = Product.entity()
               fetchRequest.predicate = NSPredicate(
                   format: "name CONTAINS %@", name
               )
               matches = try? viewContext.fetch(fetchRequest)
           }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(name: "mouse", viewContext: PersistenceController.shared.container.viewContext)
    }
}
}
