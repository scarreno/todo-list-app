//
//  AuthHelper.swift
//  todo-list-app
//
//  Created by Sergio Raúl on 02-11-21.
//

import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
   
    
}
