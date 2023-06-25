//
//  Created by Khalid Kamil on 21/06/2023.
//

import SwiftUI

struct RegistrationView: View {
    @State var email = ""
    @State var fullname = ""
    @State var password = ""
    @State var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            // image
            Image("Logo")
                .padding(.vertical, 32)
            
            // form fields
            ScrollView {
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "Enter your email address")
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    
                    InputView(text: $fullname,
                              title: "Full Name",
                              placeholder: "Enter your full name")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                    
                    ZStack(alignment: .bottomTrailing) {
                        InputView(text: $confirmPassword,
                                  title: "Confirm Password",
                                  placeholder: "Re-enter your password",
                                  isSecureField: true)
                        
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 8)
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 8)
                            }
                        }
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                
                // sign up button
                Button {
                    Task {
                        try await authViewModel.createUser(withEmail: email, password: password, fullname: fullname)
                    }
                } label: {
                    HStack {
                        Text("SIGN UP")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width-32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(12)
                .padding(.top, 16)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1 : 0.3)
                
                
                
                // sign in button
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Text("Already have an account? ")
                        Text("Sign in")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                    }
                    .font(.system(size: 14))
                    .padding(.vertical)
                }
            }
        }
    }
}

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !fullname.isEmpty
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
