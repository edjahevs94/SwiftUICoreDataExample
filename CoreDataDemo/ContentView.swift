//
//  ContentView.swift
//  CoreDataDemo
//
//  Created by EdgardVS on 15/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var name: String = ""
    @State var quantity: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Product.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    private var products: FetchedResults<Product>
    
    var body: some View {
        NavigationView {
                    VStack {
                        TextField("Product name", text: $name)
                        TextField("Product quantity", text: $quantity)
                        
                        HStack {
                            Spacer()
                            Button("Add") {
                               addProduct()
                            }
                            Spacer()
                                   NavigationLink(destination: ResultView(name: name,
                                                  viewContext: viewContext)) {
                                       Text("Find")
                                   }
                            
                            Spacer()
                            Button("Clear") {
                                name = ""
                                quantity = ""
                            }
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        
                        List {
                            ForEach(products) { product in
                                HStack {
                                    Text(product.name ?? "Not found")
                                    Spacer()
                                    Text(product.quantity ?? "Not found")
                                }
                            }
                            .onDelete(perform: deleteProduct)
                        }
                        .navigationTitle("Product Core Data")
                    }
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
    }
    
    
    
    private func addProduct() {
           
           withAnimation {
               let product = Product(context: viewContext)
               product.name = name
               product.quantity = quantity
               
               saveContext()
           }
       }
       
       private func saveContext() {
           do {
               try viewContext.save()
           } catch {
               let error = error as NSError
               fatalError("An error occured: \(error)")
           }
       }
    private func deleteProduct(offsets: IndexSet){
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            saveContext()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
