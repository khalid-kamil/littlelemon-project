//
//  Created by Khalid Kamil on 24/06/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
        
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // signs out user on backend
            self.userSession = nil // wipes user session and navigates to loaign screen
            self.currentUser = nil // wipes current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount(completion: @escaping (Result<Bool, Error>) -> Void) {
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    self.userSession = nil
                    self.currentUser = nil
                }
            }
        }
        
        
    }
    
    func deleteUserData(completion: @escaping (Result<Bool, Error>) -> Void) {
        if let uid = Auth.auth().currentUser?.uid {
            let reference = Firestore.firestore().collection("users").document(uid)
            reference.delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        }
    }
    
    func reauthenticateAccount(with password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let user = Auth.auth().currentUser {
            let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: password)
            user.reauthenticate(with: credential) { _, error in
                if let error = error {
                    print("DEBUG: Failed to reauthenticate account with error \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    // user reauthenticated
                    completion(.success(true))
                }
            }
            
        }

    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
}
