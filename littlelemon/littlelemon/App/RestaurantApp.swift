//
//  RestaurantApp.swift
//  littlelemon
//
//  Created by Khalid Kamil on 01/05/2023.
//

import SwiftUI

@main
struct RestaurantApp: App {
    @StateObject var authViewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            MainAppView()
                .environmentObject(authViewModel)
        }
    }
}
