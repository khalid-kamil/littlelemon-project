//
//  EmailView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 15/05/2023.
//

import SwiftUI

struct EmailView: View {
    @State private var email = ""
    @State private var showAlert = false
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text("Got it. Next, what's your email?")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 4)
                .multilineTextAlignment(.center)
            
            Text("This is so you can varify your account")
                .foregroundColor(.secondary)
                .font(.callout)
                .padding(.bottom, 32)
                .multilineTextAlignment(.center)
            
            TextField("Email", text: $email)
                .textFieldStyle(LittleLemonTextField())
                .autocapitalization(.none)
            
            Spacer()
            
            HStack {
                Image(systemName: "exclamationmark.lock.fill")
                Text("We'll never share your email with anyone")
                    .foregroundColor(.secondary)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 8)
            
            Button {
                if email == "" {
                    showAlert = true
                } else {
                    UserDefaults.standard.set(email, forKey: kEmail)
                    action()
                }
            } label: {
                Text("Continue")
            }
            .buttonStyle(LittleLemonButton())
            .alert("Please enter a valid email address", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
        .padding(.top, 100)
        .padding(16)
    }
}

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView {}
    }
}
