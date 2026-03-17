//
//  LoginViewModel.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var usernameError: String? = nil
    @Published var passwordError: String? = nil
    var isLoading: Bool = false
    @Published var hasLoggedIn: Bool = false
    
   

    func validate() -> Bool {
        var isValid = true

        if username.trimmingCharacters(in: .whitespaces).isEmpty {
            usernameError = "Username is required"
            isValid = false
        } else {
            usernameError = nil
        }

        if password.isEmpty {
            passwordError = "Password is required"
            isValid = false
        } else if password.count < 6 {
            passwordError = "Password must be at least 6 characters"
            isValid = false
        } else {
            passwordError = nil
        }

        return isValid
    }
    
    func simulateLogin(){
        self.isLoading = true
        UserDefaults.standard.set(username, forKey: "userName")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            self.hasLoggedIn = true
        }
        
    }
}
