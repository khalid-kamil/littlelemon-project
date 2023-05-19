//
//  SessionManager.swift
//  littlelemon
//
//  Created by Khalid Kamil on 14/05/2023.
//

import Foundation

final class SessionManager: ObservableObject {
    
    enum CurrentState {
        case loggedIn
        case loggedOut
    }
    
    @Published private(set) var currentState: CurrentState?
    
    func signIn() {
        currentState = .loggedIn
        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
    }
    
    func signOut() {
        currentState = .loggedOut
        UserDefaults.standard.set(false, forKey: kIsLoggedIn)
    }
    
    func configureCurrentState() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
        currentState = isLoggedIn ? .loggedIn : .loggedOut
    }
}
