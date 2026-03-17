//
//  CoopDukaApp.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//

import SwiftUI

@main
struct CoopDukaApp: App {
    @StateObject var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environment(\.font, Font.custom("Muli", size: 16))
        }
    }
}
