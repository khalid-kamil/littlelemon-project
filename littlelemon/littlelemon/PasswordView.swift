//
//  PasswordView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 15/05/2023.
//

import SwiftUI

struct PasswordView: View {
    @State private var password = ""
    @State private var showAlert = false
    
    @EnvironmentObject var session: SessionManager
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text("Ok, just one last step. Please choose a password.")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 4)
                .multilineTextAlignment(.center)
            
            Text("Make sure it's unique, at least 8 characters and isn't used anywhere else")
                .foregroundColor(.secondary)
                .font(.callout)
                .padding(.bottom, 32)
                .multilineTextAlignment(.center)
            
            
            SecureField("Password", text: $password)
                .textFieldStyle(LittleLemonTextField())
                .autocapitalization(.none)
            
            Spacer()
            
            Button {
                if password == "" {
                    showAlert = true
                } else {
                    UserDefaults.standard.set(password, forKey: kPassword)
                    action()
                    session.signIn()
                }
            } label: {
                Text("Register")
            }
            .buttonStyle(LittleLemonButton())
            .alert("Please create a password", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
        .padding(.top, 100)
        .padding(16)
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView {}
    }
}
