//
//  AppState.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//

import Foundation
import Combine

class AppState: ObservableObject {
    @Published var hasLoggedIn = false

    func logout() {
        hasLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "userName")
    }
}
