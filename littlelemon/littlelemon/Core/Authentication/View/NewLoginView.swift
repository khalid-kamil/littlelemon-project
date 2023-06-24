//
//  Created by Khalid Kamil on 20/06/2023.
//

import SwiftUI

struct NewLoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
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
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // forgot password?
                Button {
                    print("Resetting user password...")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding([.top, .trailing], 16)
                }
                
                // sign in button
                Button {
                    Task {
                        try await authViewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
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
                
                // sign up button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 0) {
                        Text("Don't have an account? ")
                        Text("Sign up")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                    }
                    .font(.system(size: 14))
                }
                
            }
        }
    }
}

struct NewLoginView_Previews: PreviewProvider {
    static var previews: some View {
        NewLoginView()
    }
}
