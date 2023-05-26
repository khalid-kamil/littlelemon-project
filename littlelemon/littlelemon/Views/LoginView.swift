//
//  LoginView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 14/05/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var alertMessage = "Please enter your email and password"
    @State private var showAlert = false
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        ZStack {
            Color("Secondary 3").ignoresSafeArea()
            
            VStack {
                Spacer()
                info
                emailField
                passwordField
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
    
    var emailField: some View {
        TextField("Email Address", text: $email)
            .textFieldStyle(LittleLemonTextField())
            .autocapitalization(.none)
    }
    
    var passwordField: some View {
        SecureField("Password", text: $password)
            .textFieldStyle(LittleLemonTextField())
    }
    
    var login: some View {
        Button {
            if email == UserDefaults.standard.string(forKey: kEmail) && password == UserDefaults.standard.string(forKey: kPassword) {
                withAnimation {
                    UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    session.signIn()
                }
            } else {
                showAlert = true
            }
        } label: {
            Text("Login")
        }
        .buttonStyle(LittleLemonButton())
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SessionManager())
    }
}
