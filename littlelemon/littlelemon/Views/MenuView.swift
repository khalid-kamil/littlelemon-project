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
    @State private var selectedCategory: Category = .all
    @State private var categories = Category.allCases
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                HeaderView()
                TextField("Search menu", text: $searchText)
                    .textFieldStyle(LittleLemonTextField())
                    .padding(.top, 12)
                    .padding(.horizontal, 12)
                HStack(spacing: 0) {
                    Text("Order for delivery")
                        .sectionTitleStyle()
                    Spacer()
                }
                .padding(.horizontal, 12)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id:\.self) { category in
                            Button {
                                selectedCategory = category
                            } label: {
                                Text(category.rawValue.capitalized)
                                    .sectionCategoryStyle()
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(selectedCategory == category ? Color("Primary 1") : Color("Secondary 3"))
                                    .foregroundColor(selectedCategory == category ? Color("Primary 2") : Color("Primary 1"))
                                    .clipShape(Capsule())
                                    .font(.headline)
                            }
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                Divider()
                    .padding(.horizontal, 12)
                FetchedObjects(predicate: buildPredicate(),
                               sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    List(dishes) { dish in
                        NavigationLink {
                            ItemView(dish: dish)
                        } label: {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(dish.title!)")
                                        .cardTitleStyle()
                                HStack(spacing: 0) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("The famous greek salad of crispy lettuce, peppers, olives and our Chicago ranch sauce.")
                                            .lineLimit(2)
                                            .paragraphTextStyle()
                                            .foregroundColor(Color("Primary 1"))
                                        Text("\(Dish.formatPrice(dish.price!))")
                                            .highlightTextStyle()
                                        Text(dish.category!)
                                    }
                                    .padding(.vertical, 8)
                                    Spacer()
                                    AsyncImage(url: URL(string: dish.image!)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .transition(.scale(scale: 0.1, anchor: .center))
//                                            .overlay(Material.ultraThin)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 88, height: 88)
                                    .background(Color("Secondary 3"))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .shadow(color: Color("Secondary 3"), radius: 8)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
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
        var predicate1: NSPredicate
        if searchText == "" {
            predicate1 = NSPredicate(value: true)
        } else {
            predicate1 = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
        
        var predicate2 = NSPredicate(format: "category like %@", selectedCategory.rawValue)
        if selectedCategory == .all {
            predicate2 = NSPredicate(value: true)
        }
        
        return NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
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
