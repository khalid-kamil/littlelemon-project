//
//  RestaurantApp.swift
//  littlelemon
//
//  Created by Khalid Kamil on 01/05/2023.
//

import SwiftUI
import Firebase

@main
struct RestaurantApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
