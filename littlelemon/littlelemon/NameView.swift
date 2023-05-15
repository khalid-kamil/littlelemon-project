//
//  NameView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 13/05/2023.
//

import SwiftUI

struct NameView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Text(
                    """
                    Ok, let's set up your profile!
                    First, what's your name?
                    """)
            .font(.title)
            .fontWeight(.semibold)
            .padding(.bottom, 4)
            .multilineTextAlignment(.center)
            Text("This is how you'll appear on Little Lemon")
                .foregroundColor(.secondary)
                .font(.callout)
                .padding(.bottom, 32)
            TextField("First Name", text: .constant(""))
                .textFieldStyle(LittleLemonTextField())
            TextField("Last Name", text: .constant(""))
                .textFieldStyle(LittleLemonTextField())
            Spacer()
            Button {
                // TODO: Implement continue function
            } label: {
                Text("Continue")
            }
            .buttonStyle(LittleLemonButton())
        }
        .padding(12)
    }
}


struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
            .previewLayout(.sizeThatFits)
    }
}
