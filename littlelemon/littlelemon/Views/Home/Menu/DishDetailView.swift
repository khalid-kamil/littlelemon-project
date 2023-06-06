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
    var dish: Dish
    
    var body: some View {
        VStack {
            dishImage
            dishName
            dishDescription
            dishPrice
            splitTheBill
            Spacer()
            addToBag
        }
        .ignoresSafeArea(edges: .top)
    }
}

private extension DishDetailView {
    var dishName: some View {
        Text(dish.title!)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(Color("Primary 1"))
    }
}

private extension DishDetailView {
    var dishImage: some View {
        AsyncImage(url: URL(string: dish.image!)) { image in
            image.resizable()
                .scaledToFill()
                .overlay(alignment: .bottomTrailing) {
                    Text(dish.category!)
                        .sectionCategoryStyle()
                        .foregroundColor(Color("Secondary 4"))
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color("Primary 2"))
                        }
                        .padding(8)
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
    var dishDescription: some View {
        Text("\(dish.dishDescription!)")
            .paragraphTextStyle()
    }
}

private extension DishDetailView {
    var dishPrice: some View {
        HStack {
            Text("Price:")
            Text("\(PersistenceController.formatPrice(dish.price!))")
                .highlightTextStyle()
        }
        .leadTextStyle()
        .padding()
        .frame(maxWidth: 300)
    }
}

private extension DishDetailView {
    var splitTheBill: some View {
        Button("Split the bill") {
            showSplitBillView.toggle()
        }
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
