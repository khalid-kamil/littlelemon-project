//
//  ItemView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 20/05/2023.
//

import SwiftUI

struct ItemView: View {
    var dish: Dish
    
    var body: some View {
        VStack {
            Text(dish.title!)
                .subtitleStyle()
                .foregroundColor(Color("Primary 1"))
            AsyncImage(url: URL(string: dish.image!)) { image in
                image.resizable()
                .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 300)
            .overlay(alignment: .topTrailing) {
                Text(dish.category!)
                    .sectionCategoryStyle()
                    .foregroundColor(Color("Secondary 1"))
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color("Secondary 2"))
                    }
                    .padding(8)
            }
            HStack {
                Text("Price:")
                Spacer()
                Text(dish.price!)
            }
            .leadTextStyle()
            .padding()
            .frame(maxWidth: 300)
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(dish: .preview())
    }
}
