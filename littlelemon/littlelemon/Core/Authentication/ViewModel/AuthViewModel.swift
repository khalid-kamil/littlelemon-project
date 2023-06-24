//
//  Created by Khalid Kamil on 24/06/2023.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() { }
    
    func signIn(withEmail email: String, password: String) async throws {
        
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        
    }
    
}
