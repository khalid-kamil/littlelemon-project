//
//  Created by Khalid Kamil on 23/06/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var displayReauthenticationAlert = false
    @State private var canDelete = false
    @State private var reauthenticationFailed = false
    @State private var errorText = ""
    @State private var password = ""
    
    var body: some View {
        if let user = authViewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        
                    }
                }
                
                Section("General") {
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Account") {
                    Button {
                        authViewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                    }
                    
                    Button {
                        displayReauthenticationAlert = true
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                    }
                    
                }
                
            }
            .alert("Account Verification", isPresented: $displayReauthenticationAlert) {
                SecureField("Password", text: $password)
                Button("Confirm") {
                    authViewModel.reauthenticateAccount(with: password) { result in
                        handleResult(result)
                    }
                }
                
                Button("Cancel", role: .cancel) {
                    password = ""
                }
            } message: {
                Text("Making significant changes to an account requires user verification. Enter the password for \(user.email) to delete your account.")
            }
            // Delete account
            .alert("Warning", isPresented: $canDelete) {
                Button("Delete", role: .destructive) {
                    
                    authViewModel.deleteUserData { result in
                        switch result {
                        case .success:
                            authViewModel.deleteAccount { result in
                                if case let .failure(error) = result {
                                    print("DEBUG: Failed to delete account with error \(error.localizedDescription)")
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                }
                
                Button("Cancel", role: .cancel) { }
            }  message: {
                Text("Are you sure you want to delete your account? This action cannot be undone.")
            }
            // Reauthorisation failed
            .alert("Verification Failed", isPresented: $reauthenticationFailed) {
                Button("Cancel", role: .cancel) { }
            }  message: {
                Text(errorText)
            }
            
        }
    }
    
    func handleResult(_ result: Result<Bool, Error>) {
        switch result {
        case .success:
            canDelete = true
            
            password = ""
        case .failure(let error):
            reauthenticationFailed = true
            password = ""
            errorText = error.localizedDescription
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
