//
//  LoginView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 14/05/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        ZStack {
            Color("Secondary 3").ignoresSafeArea()
            
            VStack {
                Spacer()
                info
                email
                password
                Spacer()
                Spacer()
                login
            }
            .padding()
        }
    }
}

private extension LoginView {
    var info: some View {
        VStack(spacing: 16) {
            Text("👋")
                .font(.system(size: 96))
            
            Text("Welcome back to Little Lemon!")
            .font(.title)
            .fontWeight(.bold)
            
            Text("To start ordering your favourite meals, please enter your email and password.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .font(.callout)
        }
        .multilineTextAlignment(.center)
        .padding(.bottom, 48)
    }
    
    var email: some View {
        TextField("Email Address", text: .constant(""))
            .textFieldStyle(LittleLemonTextField())
    }
    
    var password: some View {
        SecureField("Password", text: .constant(""))
            .textFieldStyle(LittleLemonTextField())
    }
    
    var login: some View {
        Button {
            withAnimation {
                session.signIn()
            }
        } label: {
            Text("Login")
        }
        .buttonStyle(LittleLemonButton())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SessionManager())
    }
}
