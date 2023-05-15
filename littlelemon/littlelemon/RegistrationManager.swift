//
//  RegistrationManager.swift
//  littlelemon
//
//  Created by Khalid Kamil on 15/05/2023.
//

import Foundation

final class RegistrationManager: ObservableObject {
    
    enum Screen: Int, CaseIterable {
        case name
        case email
        case password
    }
    
    @Published var active: Screen = Screen.allCases.first!
    
    func next() {
        let nextScreenIndex = min(active.rawValue + 1, Screen.allCases.last!.rawValue)
        if let screen = Screen(rawValue: nextScreenIndex) {
            active = screen
        }
    }
    
    func previous() {
        let previousScreenIndex = max(active.rawValue - 1, Screen.allCases.first!.rawValue)
        if let screen = Screen(rawValue: previousScreenIndex) {
            active = screen
        }
    }
}
