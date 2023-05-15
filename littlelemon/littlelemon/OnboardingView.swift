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

struct OnboardingView: View {
    @State private var showTerms = false
    @State private var showPrivacyPolicy = false
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header
                hero
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
    var header: some View {
        HStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(height: 36)
        }
        .padding(.bottom, 8)
    }
    
    var hero: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Little Lemon")
                    .displayTitleStyle()
                    .foregroundColor(Color("Primary 2"))
                    .padding(.bottom, -16)
                
                Text("Chicago")
                    .subtitleStyle()
                    .foregroundColor(.white)
                    .padding(.bottom, 16)
                
                Text("""
                        We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
                        """)
                .paragraphTextStyle()
                .foregroundColor(.white)
                .frame(maxWidth: 200)
                .padding(.bottom, 32)
            }
            Spacer()
        }
        .overlay(alignment: .bottomTrailing, content: {
            Image("Hero image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 140, height: 140, alignment: .center)
                .cornerRadius(16)
                .padding(.bottom, 24)
        })
        
        .padding(.horizontal, 16)
        .background(Color("Primary 1"))
    }
    
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
