//
//  LittleLemonButtonStyle.swift
//  littlelemon
//
//  Created by Khalid Kamil on 14/05/2023.
//

import SwiftUI

struct LittleLemonButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("Primary 1"))
            .foregroundColor(Color(.white))
            .clipShape(RoundedRectangle(cornerRadius: 16.0))
            .font(.headline)
    }
}
