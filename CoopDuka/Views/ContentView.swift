//
//  ContentView.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        if appState.hasLoggedIn {
            HomeView()
        } else {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea(edges: .all)
                LoginView()
            }
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
