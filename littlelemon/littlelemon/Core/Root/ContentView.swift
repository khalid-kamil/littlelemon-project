//
//  ContentView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 24/06/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                HomeView()
            } else {
                NewLoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
