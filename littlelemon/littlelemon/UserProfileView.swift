//
//  UserProfileView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 17/05/2023.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        VStack(spacing: 16) {
            
            Image("profile-image-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(alignment: .bottomTrailing) {
                    Image(systemName: "camera.circle.fill")
                        .renderingMode(.original)
                        .foregroundColor(Color("Secondary 1"))
                        .font(.system(size: 32))
                        .padding([.trailing, .bottom], -8)
                }
                .overlay(alignment: .topLeading) {
                    Image(systemName: "xmark.circle.fill")
                        .renderingMode(.original)
                        .foregroundColor(.gray)
                        .font(.system(size: 24))
                }
                .padding()
            
            HStack {
                Text(UserDefaults.standard.object(forKey: kFirstName) as? String ?? "Tilly")
                Text(UserDefaults.standard.object(forKey: kLastName) as? String ?? "Doe")
            }
            .subtitleStyle()
            .foregroundColor(Color("Primary 1"))
            
            Form {
                Section("Personal Information") {
                    HStack {
                        Text("Name")
                        TextField("Name", text: .constant("Tilly Doe"))
                            .autocorrectionDisabled()
                            .multilineTextAlignment(.trailing)
                            .disabled(true)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Email")
                        TextField("Email", text: .constant("placeholder@email.com"))
                            .autocorrectionDisabled()
                            .multilineTextAlignment(.trailing)
                            .disabled(true)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Phone Number")
                        TextField("Phone Number", text: .constant("123456789"))
                            .autocorrectionDisabled()
                            .multilineTextAlignment(.trailing)
                            .disabled(true)
                            .foregroundColor(.secondary)
                    }
                }
                Section("Personal Information") {
                    Toggle(isOn: .constant(true)) {
                        Text("Order Status")
                        
                    }
                    Toggle(isOn: .constant(true)) {
                        Text("Password Changes")
                        
                    }
                    Toggle(isOn: .constant(true)) {
                        Text("Special Offers")
                        
                    }
                    Toggle(isOn: .constant(true)) {
                        Text("Newsletter")
                        
                    }
                }
            }
            
            
            Button {
                withAnimation {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    session.signOut()
                }
            } label: {
                Text("Sign Out")
            }
            .buttonStyle(LittleLemonButton())
            .padding()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
