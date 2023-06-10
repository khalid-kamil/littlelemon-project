//
//  HomeView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 14/05/2023.
//

import SwiftUI

struct HomeView: View {
    private let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            MenuView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "menucard")
                }
            GameView()
                .tabItem {
                    Label("Rewards", systemImage: "dice")
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
