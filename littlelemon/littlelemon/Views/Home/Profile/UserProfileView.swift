//
//  UserProfileView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 17/05/2023.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var session: SessionManager
    @State private var firstName = UserDefaults.standard.object(forKey: kFirstName) as? String ?? "First"
    @State private var lastName = UserDefaults.standard.object(forKey: kLastName) as? String ?? "Last"
    @State private var email = UserDefaults.standard.object(forKey: kEmail) as? String ?? "Email"
    @State private var orderUpdates = true
    @State private var passwordUpdates = true
    @State private var offersUpdates = true
    @State private var newsletterUpdates = true
    @State private var isEditingProfile = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("profile-image-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(alignment: .bottomTrailing) {
                        if isEditingProfile {
                            Image(systemName: "camera.circle.fill")
                                .renderingMode(.original)
                                .foregroundColor(Color("Secondary 1"))
                                .font(.system(size: 32))
                                .padding([.trailing, .bottom], -8)
                        }
                    }
                    .padding(.vertical, 32)
                
                Form {
                    Section("Personal Information") {
                        HStack {
                            Text("First Name")
                            TextField("First Name", text: $firstName)
                                .autocorrectionDisabled()
                                .multilineTextAlignment(.trailing)
                                .disabled(!isEditingProfile)
                                .foregroundColor(isEditingProfile ? Color("Secondary 1") : Color("Primary 3"))
                        }
                        
                        HStack {
                            Text("Last Name")
                            TextField("Last Name", text: $lastName)
                                .autocorrectionDisabled()
                                .multilineTextAlignment(.trailing)
                                .disabled(!isEditingProfile)
                                .foregroundColor(isEditingProfile ? Color("Secondary 1") : Color("Primary 3"))
                        }
                        
                        HStack {
                            Text("Email")
                            TextField("Email", text: $email)
                                .autocorrectionDisabled()
                                .multilineTextAlignment(.trailing)
                                .disabled(!isEditingProfile)
                                .foregroundColor(isEditingProfile ? Color("Secondary 1") : Color("Primary 3"))
                        }
                        
                    }
                    Section("Personal Information") {
                        Toggle(isOn: $orderUpdates) {
                            Text("Order Status")
                            
                        }
                        Toggle(isOn: $passwordUpdates) {
                            Text("Password Changes")
                            
                        }
                        Toggle(isOn: $offersUpdates) {
                            Text("Special Offers")
                            
                        }
                        Toggle(isOn: $newsletterUpdates) {
                            Text("Newsletter")
                            
                        }
                    }
                }
                .scrollDisabled(true)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .toolbarBackground(
                Color.white,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if isEditingProfile {
                        Button("Cancel") {
                            isEditingProfile.toggle()
                            email = UserDefaults.standard.object(forKey: kEmail) as? String ?? "Email"
                            firstName = UserDefaults.standard.object(forKey: kFirstName) as? String ?? "First"
                            lastName = UserDefaults.standard.object(forKey: kLastName) as? String ?? "Last"
                        }
                    } else {
                        Button("Edit Profile") {
                            isEditingProfile.toggle()
                        }
                    }
                    
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    if isEditingProfile {
                        Button("Save") {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            isEditingProfile.toggle()
                        }
                        .foregroundColor(Color("Secondary 1"))
                    } else {
                        Button("Sign Out") {
                            withAnimation {
                                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                                session.signOut()
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
