//
//  AuthViewModel.swift
//  SwiftUIForm
//
//  Created by Jose on 24/4/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

final class AuthViewModel: ObservableObject {
    
    @Published var user: User?
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener {
            [weak self] _, user in
                guard let self = self else {
                    return
                }
            self.user = user
    }
  }
// function to sign-in
// function to create an account
// function to logout
// function to reset password
}
