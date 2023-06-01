//
//  ItemView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 20/05/2023.
//

import SwiftUI

struct ItemView: View {
    @State var showSplitBillView = false
    @State var showAlert = false
    var dish: Dish
    
    var body: some View {
        VStack {
            Text(dish.title!)
                .subtitleStyle()
                .foregroundColor(Color("Primary 1"))
            AsyncImage(url: URL(string: dish.image!)) { image in
                image.resizable()
                    .scaledToFit()
                    .overlay(alignment: .topTrailing) {
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
            .frame(maxWidth: 300, maxHeight: 240)
            
            Text("\(dish.dishDescription!)")
                .paragraphTextStyle()
            
            HStack {
                Text("Price:")
                Text("\(Dish.formatPrice(dish.price!))")
                    .highlightTextStyle()
            }
            .leadTextStyle()
            .padding()
            .frame(maxWidth: 300)
            
            Button("Split the bill") {
                showSplitBillView.toggle()
            }
            .sheet(isPresented: $showSplitBillView) {
                SplitBillView()
            }
            
            Spacer()
            
            Button {
                showAlert.toggle()
            } label: {
                Text("Order Now")
            }
            .buttonStyle(LittleLemonButton())
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Order Successful!"), message: Text("Your order of \(dish.title!) is on its way!"))
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(dish: .preview())
    }
}
