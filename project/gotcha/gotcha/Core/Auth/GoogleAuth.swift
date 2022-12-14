//
//  AuthViewModel.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/19.
//

import Foundation
import Firebase
import FirebaseFirestore
import GoogleSignIn

class GoogleAuth: ObservableObject {
    
    @Published var state: SignInStatus = .signedOut
    
    init() {}
    
    // Sign-in Status
    enum SignInStatus {
        case signedIn
        case signedOut
        case newUser
    }
    
    func signIn() {
        
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, err in
                authenticateUser(who: user, err)
            }
          } else {
              guard let clientID = FirebaseApp.app()?.options.clientID else { return }
              
              let config = GIDConfiguration(clientID: clientID)
              
              guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
              guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
              GIDSignIn.sharedInstance.signIn(with: config, presenting: rootViewController) { [unowned self] user, err in
                  authenticateUser(who: user, err)
              }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            self.state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setSignedIn() {
        self.state = .signedIn
    }
    
    private func authenticateUser(who user: GIDGoogleUser?, _ error: Error?) {
        
        // Error handling. Return immediately
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let db = Firestore.firestore()
        
        // User handling
        guard let auth = user?.authentication else { return } // Ensure authentication
        guard let idToken = auth.idToken else { return } // Ensure idToken for user
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: auth.accessToken) // Credential for user
        
        Auth.auth().signIn(with: credential) {[unowned self] (_, err) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let user = Auth.auth().currentUser else { return }
                print("User is \(user.uid)")
                let docRef = db.collection("users").document(user.uid)
                docRef.getDocument { doc, err in
                    if let err = err {
                        print("Error getting documents. \(err)")
                    } else {
                        // No error
                        guard let doc = doc else { return }
                        if doc.exists {
                            print("Already existed user!")
                            self.state = .signedIn
                        } else {
                            print("New User!")
                            self.state = .newUser
                        }
                    }
                }
            }
        }
    }
}
