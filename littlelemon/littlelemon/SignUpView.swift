//
//  SignUpView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 15/05/2023.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var manager = RegistrationManager()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var onFirstScreen = true
    
    var body: some View {
        ZStack {
            Color("Secondary 3").ignoresSafeArea()
            
            TabView(selection: $manager.active) {
                
                NameView(action: manager.next)
                    .tag(RegistrationManager.Screen.name)
                EmailView(action: manager.next)
                    .tag(RegistrationManager.Screen.email)
                PasswordView {}
                    .tag(RegistrationManager.Screen.password)
                
            }
            .animation(.easeInOut, value: manager.active)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .overlay(alignment: .topLeading) {
            Button {
                if onFirstScreen {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    manager.previous()
                }
            } label: {
                Image(systemName: "chevron.backward")
                    .symbolVariant(.circle.fill)
                    .foregroundColor(.accentColor)
                    .font(.system(size: 32,
                                  weight: .bold,
                                  design: .rounded))
                    .padding(12)
            }

        }
        .onAppear {
            UIScrollView.appearance().isScrollEnabled = false
        }
        .onDisappear {
            UIScrollView.appearance().isScrollEnabled = true
        }
        .onChange(of: manager.active, perform: { newValue in
            if newValue == RegistrationManager.Screen.allCases.first {
                onFirstScreen = true
            } else {
                onFirstScreen = false
            }
        })
        .navigationBarHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
