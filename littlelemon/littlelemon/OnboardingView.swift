//
//  OnboardingView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 03/05/2023.
//

import SwiftUI

let keyFirstName = "first name key"
let keyLastName = "last name key"
let keyEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct OnboardingView: View {
    @State private var showTerms = false
    @State private var showPrivacyPolicy = false
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView()
                callToAction
                Spacer()
                footer
            }
        }
        .accentColor(Color(red: 73/255, green: 94/255, blue: 87/255))
    }
    
    func handleURL(_ url: URL) -> OpenURLAction.Result {
        switch url.fragment {
        case "terms-conditions":
            showTerms.toggle()
        case "privacy-policy":
            showPrivacyPolicy.toggle()
//        case "login":
        default:
            return .discarded
        }
        return .handled
    }
}

private extension OnboardingView {
    var callToAction: some View {
        VStack(spacing: 0) {
            Text("Welcome to Little Lemon. Let's get started.")
                .foregroundColor(.secondary)
                .font(.callout)
                .padding(.vertical, 40)
            NavigationLink {
                SignUpView()
            } label: {
                Text("Sign up with email")
            }
            .buttonStyle(LittleLemonButton())
            .padding(.bottom, 12)
            
            Text("We'll never share anything without your permission.")
                .foregroundColor(.secondary)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .padding(.bottom, 32)
            
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.secondary)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                NavigationLink {
                    LoginView()
                } label: {
                    Text("Login")
                        .foregroundColor(Color("Primary 1"))
                        .font(.footnote)
                        .fontWeight(.medium)
                        .underline()
                }
                
            }
        }
        .padding(.horizontal, 16)
    }
    
    var footer: some View {
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
        .sheet(isPresented: $showTerms) { TermsAndConditionsView()}
        .sheet(isPresented: $showPrivacyPolicy) {PrivacyPolicyView()}
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
