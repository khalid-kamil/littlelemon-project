//
//  MenuView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 17/05/2023.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    
    var body: some View {
        VStack {
            HeaderView()
            NavigationStack {
                TextField("Search menu", text: $searchText)
                    .textFieldStyle(LittleLemonTextField())
                    .padding(12)
                FetchedObjects(predicate: buildPredicate(),
                               sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    List(dishes) { dish in
                        NavigationLink {
                            ItemView(dish: dish)
                        } label: {
                            HStack {
                                Text("\(dish.title!) - \(dish.price!)")
                                Spacer()
                                AsyncImage(url: URL(string: dish.image!)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 120, height: 120)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    
//    Step 1: Sorting by name
//    Create a new function called buildSortDescriptors and make it return an array of NSSortDescriptor instances for Dish objects.
//    Inside the function, declare a return statement followed by the array literal.
//    Inside the array literal, initialize an NSSortDescriptor. Use "title" for the key argument, true for the ascending argument and #selector(NSString.localizedStandardCompare) for the selector argument.
//    The function now returns an array with one sort descriptor that will sort the Dish data by title in ascending order.
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString.localizedStandardCompare(_:)))]
    }
    
//    Step 4: Add a function called buildPredicate that returns a predicate to filter the FetchedObjets results
//     - Inside the function, check if the searchText state variable is empty.
//     - If it is empty, return a new instance of the NSPredicate passing true to the value argument.
//     - If it is not empty, return a new instance of the NSPredicate by passing the following into its format argument: "title CONTAINS[cd] %@", searchText. It will try to match part of the title property of the Dish to the given text and return all objects that match.
    func buildPredicate() -> NSPredicate {
        if searchText == "" {
            return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    
    func getMenuData() {
        // clear database  before saving menu list each time
        PersistenceController().clear()
        
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // Parsing response into models using JSONDecoder
            if let data = data {
                let decoder = JSONDecoder()
                guard let result = try? decoder.decode(MenuList.self, from: data) else {
                    print("JSON decoding error")
                    return
                }
                for item in result.menu {
                    let oneDish = Dish(context: viewContext)
                    oneDish.title = item.title
                    oneDish.image = item.image
                    oneDish.price = item.price
                    oneDish.category = item.category
                }
                try? viewContext.save()
                print("View Context saved.")
            }
        }
        task.resume()
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
