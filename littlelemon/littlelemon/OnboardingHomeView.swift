//
//  SignUpView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 13/05/2023.
//

import SwiftUI

struct OnboardingHomeView: View {
    @State private var selectedSheet = ""
    @State private var showingWebSheet = false
    
    var body: some View {
        VStack {
            Spacer()
            Image("Logo")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(width: 240)
                .padding(.bottom, 64)
            
            Text("Welcome to Little Lemon. Let's get started.")
                .foregroundColor(.secondary)
                .font(.callout)
                .padding(.bottom, 32)
            NavigationLink {
                NameView()
            } label: {
                    Text("Sign up with email")
            }
            .buttonStyle(LittleLemonButton())
            .padding(.bottom, 8)
            
            Text("We'll never share anything without your permission.")
                .foregroundColor(.secondary)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .padding(.bottom)
            
            Spacer()
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.secondary)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                Text("Login")
                    .foregroundColor(Color("Primary 1"))
                    .font(.footnote)
                    .fontWeight(.medium)
                    .underline()
            }
            
            
            Spacer()
            VStack {
                Text("By signing up, you agree to our ")
                + Text("[Terms and Condititons](#terms-conditions)")
                    .bold()
                    .underline()
                + Text(".")
                Text("Learn how we use your data in our ")
                + Text("[Privacy Policy](#privacy-policy)")
                    .bold()
                    .underline()
                + Text(".")
            }
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundColor(.secondary)
            .tint(.secondary)
            .environment(\.openURL, OpenURLAction(handler: handleURL))
        }
        .padding(12)
        .sheet(isPresented: $showingWebSheet) {
            WebSheetView(content: $selectedSheet)
        }
    }
    
    func handleURL(_ url: URL) -> OpenURLAction.Result {
        switch url.fragment {
        case "terms-conditions":
            selectedSheet = "Terms and Conditions"
        case "privacy-policy":
            selectedSheet = "Privacy Policy"
        default:
            return .discarded
        }
        showingWebSheet.toggle()
        return .handled
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingHomeView()
    }
}
