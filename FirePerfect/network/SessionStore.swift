

import Foundation
import Combine
import Firebase
class SessionStore: ObservableObject {
//    Buo'zgaruvchi orqali SessionStore da bo'layotgan barcha o'zgaruvchilarni sezib turamiz
    var didChange = PassthroughSubject<SessionStore, Never>()
    
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?

    func listen () { // Projectni oxirgi xolatini eslab turadi 
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Got user: \(user)")
                self.session = User(uid: user.uid, email: user.email, displayName: user.displayName)
            } else {
                self.session = nil
            }
        }
    }
    // additional methods (sign up, sign in) will go here
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
}
