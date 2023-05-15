//
//  PasswordView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 15/05/2023.
//

import SwiftUI

struct PasswordView: View {
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
            
            
            SecureField("Password", text: .constant(""))
                .textFieldStyle(LittleLemonTextField())
            
            Spacer()
            
            Button {
                action()
                session.signIn()
            } label: {
                Text("Let's Go")
            }
            .buttonStyle(LittleLemonButton())
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
