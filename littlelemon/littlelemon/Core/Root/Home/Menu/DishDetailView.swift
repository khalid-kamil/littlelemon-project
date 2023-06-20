//
//  ItemView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 20/05/2023.
//

import SwiftUI

struct DishDetailView: View {
    @State var showSplitBillView = false
    @State var showAlert = false
    @State var favourite = false
    var dish: Dish
    
    var body: some View {
        NavigationStack {
            VStack {
                dishImage
                HStack {
                    VStack(alignment: .leading) {
                        dishName
                        dishCategory
                        dishPrice
                        dishDescription
                    }
                    Spacer()
                }
                .padding(.leading, 12)
                Spacer()
                splitTheBill
                addToBag
            }
            .ignoresSafeArea(edges: .top)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    favourite.toggle()
                // TODO: Implement add to favourites
                } label: {
                    Image(systemName: favourite ? "star.fill" : "star")
                        .foregroundColor(Color("Primary 2"))
                }
            }
        }
    }
}

private extension DishDetailView {
    var dishImage: some View {
            AsyncImage(url: URL(string: dish.image!)) { image in
                image.resizable()
                    .scaledToFill()
                    .overlay(alignment: .top) {
                        Rectangle()                         // Shapes are resizable by default
                                .foregroundColor(.clear)
                                .frame(height: 200)// Making rectangle transparent
                                .background(LinearGradient(gradient: Gradient(colors: [.white.opacity(0.7), .clear]), startPoint: .top, endPoint: .bottom))
                    }
            } placeholder: {
                ZStack {
                    Color.gray
                        .opacity(30)
                    ProgressView()
                }
            }
            .frame(maxHeight: 300)
    }
}


private extension DishDetailView {
    var dishName: some View {
        Text(dish.title!)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(Color("Primary 1"))
            .padding(.top, 16)
    }
}

private extension DishDetailView {
    var dishCategory: some View {
        Text(dish.category!)
            .sectionCategoryStyle()
            .foregroundColor(Color("Primary 2"))
            .padding(.top, 2)
    }
}

private extension DishDetailView {
    var dishPrice: some View {
        Text("\(PersistenceController.formatPrice(dish.price!))")
            .highlightTextStyle()
            .padding(.top, 2)
    }
}

private extension DishDetailView {
    var dishDescription: some View {
        Text("\(dish.dishDescription!)")
            .paragraphTextStyle()
            .padding(.top, 2)
    }
}

private extension DishDetailView {
    var splitTheBill: some View {
        Button("Split the bill") {
            showSplitBillView.toggle()
        }
        .padding(.top, 2)
        .sheet(isPresented: $showSplitBillView) {
            SplitBillView(billAmount: Double(dish.price!)!)
        }
    }
}

private extension DishDetailView {
    var addToBag: some View {
        Button {
            showAlert.toggle()
        } label: {
            Text("Add to bag")
        }
        .buttonStyle(LittleLemonButton())
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Item added to bag"), message: Text("Your order of \(dish.title!) is on its way!"))
        }
    }
    
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        DishDetailView(dish: PersistenceController.preview())
    }
}
