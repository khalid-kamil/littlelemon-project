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
            Image("iccoLogo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100, maxHeight: 120)
                .padding(.vertical, 32)
            
            // form fields
            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email Address",
                          placeholder: "Enter your email address")
                .autocapitalization(.none)
                
                InputView(text: $fullname,
                          title: "Full Name",
                          placeholder: "Enter your full name")
                .autocapitalization(.none)
                
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          isSecureField: true)
                
                InputView(text: $confirmPassword,
                          title: "Confirm Password",
                          placeholder: "Re-enter your password",
                          isSecureField: true)
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
            
            Spacer()
            
            // sign in button
            Button {
                dismiss()
            } label: {
                HStack(spacing: 0) {
                    Text("Already have an account? ")
                    Text("Sign in")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                }
                .font(.system(size: 14))
            }

            
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
