//
//  NameView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 13/05/2023.
//

import SwiftUI

struct NameView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var showAlert = false
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text("Ok, let's set up your profile! First, what's your name?")
            .font(.title)
            .fontWeight(.semibold)
            .padding(.bottom, 4)
            .multilineTextAlignment(.center)
            
            Text("This is how you'll appear on Little Lemon")
                .foregroundColor(.secondary)
                .font(.callout)
                .padding(.bottom, 32)
                .multilineTextAlignment(.center)
            
            TextField("First Name", text: $firstName)
                .textFieldStyle(LittleLemonTextField())
            
            TextField("Last Name", text: $lastName)
                .textFieldStyle(LittleLemonTextField())
            
            Spacer()
            
            Button {
                if firstName == "" || lastName == "" {
                    showAlert = true
                } else {
                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                    UserDefaults.standard.set(lastName, forKey: kLastName)
                    action()
                }
            } label: {
                Text("Continue")
            }
            .buttonStyle(LittleLemonButton())
            .alert("Please enter your first name and last name", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
        .padding(.top, 100)
        .padding(16)
    }
}


struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView {}
    }
}
