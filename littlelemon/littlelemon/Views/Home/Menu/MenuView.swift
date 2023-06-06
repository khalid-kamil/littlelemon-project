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
        NavigationStack {
            VStack(spacing: 0) {
                logo
                hero
                searchBar
                categorySelection
                fetchedMenuList
            }
        }
        .onAppear {
            PersistenceController.shared.getMenuData()
        }
    }
}

private extension MenuView {
    var logo: some View {
        HStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(height: 36)
        }
        .padding(.bottom, 8)
    }
}
 
private extension MenuView {
    var hero: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Little Lemon")
                .displayTitleStyle()
                .foregroundColor(Color("Primary 2"))
                .padding(.bottom, -16)
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Chicago")
                        .subtitleStyle()
                        .foregroundColor(.white)
                        .padding(.bottom, 16)
                    
                    Text("""
                            We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
                            """)
                    .fixedSize(horizontal: false, vertical: true)
                    .paragraphTextStyle()
                    .foregroundColor(.white)
                    .frame(maxWidth: 200)
                    .padding(.bottom, 32)
                }
                
                Image("Hero image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 140, alignment: .center)
                    .cornerRadius(16)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 16)
        .background(Color("Primary 1"))
    }
}
 
private extension MenuView {
    var searchBar: some View {
        TextField("Search menu", text: $searchText)
            .textFieldStyle(LittleLemonTextField())
            .padding(.top, 12)
            .padding(.horizontal, 12)
    }
}
    
private extension MenuView {
    var categorySelection: some View {
        VStack(alignment: .leading) {
            
            Text("Order for delivery")
                .sectionTitleStyle()
            
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
            .padding(.bottom, 8)
            
            Divider()
                .padding(.horizontal, 12)
        }
        .padding(.leading, 12)
    }
}

private extension MenuView {
    var fetchedMenuList: some View {
        FetchedObjects(predicate: PersistenceController.shared.buildPredicate(from: searchText, and: selectedCategory.rawValue),
                       sortDescriptors: PersistenceController.shared.buildSortDescriptors()) { (dishes: [Dish]) in
            List(dishes) { dish in
                NavigationLink {
                    DishDetailView(dish: dish)
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
                                Text("\(PersistenceController.formatPrice(dish.price!))")
                                    .highlightTextStyle()
                            }
                            .padding(.vertical, 8)
                            Spacer()
                            AsyncImage(url: URL(string: dish.image!)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .transition(.scale(scale: 0.1, anchor: .center))
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

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
