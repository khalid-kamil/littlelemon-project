//
//  MenuView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 17/05/2023.
//

import SwiftUI

struct MenuView: View {
    @State var searchText = ""
    @State private var selectedCategory: Category = .all
    private var categories = Category.allCases
    
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
                FetchedObjects(predicate: PersistenceController.shared.buildPredicate(from: searchText, and: selectedCategory.rawValue),
                               sortDescriptors: PersistenceController.shared.buildSortDescriptors()) { (dishes: [Dish]) in
                    List(dishes) { dish in
                        NavigationLink {
                            ItemView(dish: dish)
                        } label: {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(dish.title!)")
                                        .cardTitleStyle()
                                HStack(spacing: 0) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("\(dish.dishDescription!)")
                                            .lineLimit(2)
                                            .paragraphTextStyle()
                                            .foregroundColor(Color("Primary 1"))
                                        Text("\(Dish.formatPrice(dish.price!))")
                                            .highlightTextStyle()
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
            PersistenceController.shared.getMenuData()
        }
    }
}



struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
