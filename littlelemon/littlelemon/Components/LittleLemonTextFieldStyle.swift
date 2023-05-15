//
//  LittleLemonTextFieldStyle.swift
//  littlelemon
//
//  Created by Khalid Kamil on 14/05/2023.
//

import SwiftUI

struct LittleLemonTextField: TextFieldStyle {
    // Hidden function to conform to this protocol
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(Color("Primary 3"), lineWidth: 1.0)
                .frame(height: 48)
            
            configuration
                .padding(.leading)
                .foregroundColor(.gray)
                .accentColor(Color("Primary 1"))
        }
        .padding(.bottom, 16)
    }
}
