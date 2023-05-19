//
//  HomeView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 14/05/2023.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        TabView {
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "menucard")
                }
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SessionManager())
    }
}
