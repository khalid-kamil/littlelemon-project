//
//  MainAppView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 14/05/2023.
//

import SwiftUI

struct MainAppView: View {
    @StateObject private var session = SessionManager()
    
    var body: some View {
        ZStack {
            switch session.currentState {
            case .loggedIn:
                HomeView()
                    .environmentObject(session)
                    .transition(.opacity)
            default:
                OnboardingView()
                    .environmentObject(session)
                    .transition(.opacity)
            }
        }
        .onAppear(perform: session.configureCurrentState)
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
